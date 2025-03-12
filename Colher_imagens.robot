*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Library    RequestsLibrary
Library    ImageHorizonLibrary
Library    image_comparator


*** Variables ***
${PASTA_REFERENCIA}     imagens_referencia
${PASTA_REFERENCIA}     imagens_atual
${IMAGEM_SELETORES}     //img[@class="inventory_item_img"]   # Ajuste conforme necessário

${input_name}        id:user-name
${input_password}    id:password
${button_submit}     id:login-button

*** Keywords ***
Baixar Imagem
    [Arguments]    ${url}    ${caminho}
    ${response}    GET    ${url}
    Create Binary File    ${caminho}    ${response.content}


Acesse o site Saucedemo
    Open Browser    https://www.saucedemo.com/    chrome
    Maximize browser window

Fechar navegador
    Close Browser


Faça o login
    Input Text    ${input_name}    standard_user
    Sleep    1s
    Input Text    ${input_password}    secret_sauce
    Sleep    1s
    Click Element    ${button_submit}
    Sleep    3s
    Wait Until Page Contains    Products

*** Test Cases ***

Coletar Imagens da Página Principal
    [Documentation]    Captura as imagens dos itens e salva localmente
    Acesse o site Saucedemo
    Faça o login
    Wait Until Element Is Visible    ${IMAGEM_SELETORES}

    # Criar a pasta se não existir
    Create Directory    ${PASTA_REFERENCIA}

    ${imagens}    Get WebElements    ${IMAGEM_SELETORES}
    ${indice}    Set Variable    1

    FOR    ${imagem}    IN    @{imagens}
        ${src}    Get Element Attribute    ${imagem}    src
        ${caminho_arquivo}    Set Variable    ${PASTA_REFERENCIA}/imagem_${indice}.jpg
        Baixar Imagem    ${src}    ${caminho_arquivo}
        ${indice}    Evaluate    ${indice} + 1
    END

    Close Browser

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
