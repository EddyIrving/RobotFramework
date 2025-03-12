*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Library    RequestsLibrary
Library    ImageHorizonLibrary

*** Variables ***
${URL}                 https://seudominio.com    # URL da página
${PASTA_REFERENCIA}    imagens_referencia        # Pasta onde estão as imagens salvas
${PASTA_ATUAL}         imagens_atuais            # Pasta temporária para as imagens do teste
${BROWSER}             Chrome
${IMAGEM_SELETORES}    xpath//img[contains(@class, 'item-image')]  # Ajuste conforme necessário

*** Test Cases ***
Comparar Imagens da Página com as Referências
    [Documentation]    Verifica se as imagens da página são as mesmas da base de referência
    Open Browser    ${URL}    ${BROWSER}
    Wait Until Element Is Visible    ${IMAGEM_SELETORES}

    # Criar a pasta para imagens atuais se não existir
    Create Directory    ${PASTA_ATUAL}

    ${imagens}    Get WebElements    ${IMAGEM_SELETORES}
    ${indice}    Set Variable    1

    FOR    ${imagem}    IN    @{imagens}
        ${src}    Get Element Attribute    ${imagem}    src
        ${caminho_atual}    Set Variable    ${PASTA_ATUAL}/imagem_${indice}.jpg
        ${caminho_referencia}    Set Variable    ${PASTA_REFERENCIA}/imagem_${indice}.jpg

        # Baixar imagem da página atual
        Baixar Imagem    ${src}    ${caminho_atual}

        # Comparar com a imagem de referência
        Comparar Imagem    ${caminho_referencia}    ${caminho_atual}

        ${indice}    Evaluate    ${indice} + 1
    END

    Close Browser

*** Keywords ***
Baixar Imagem
    [Arguments]    ${url}    ${caminho}
    ${response}    GET    ${url}
    Create Binary File    ${caminho}    ${response.content}

Comparar Imagem
    [Arguments]    ${imagem_ref}    ${imagem_atual}
    ${resultado}    Compare Images    ${imagem_ref}    ${imagem_atual}
    Run Keyword If    ${resultado}==False    Fail    A imagem mudou: ${imagem_atual}
