*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${input_name}        id:user-name
${input_password}    id:password
${button_submit}     id:login-button
${URL}                https://www.saucedemo.com/v1/inventory.html
*** Keywords ***
Acesse o site Robot
    Open Browser    http://robotframework.org/

Acesse o site Saucedemo
    Open Browser    https://www.saucedemo.com/
    Maximize Browser Window

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

Preencha o login válido
    Input Text    ${input_name}    standard_user

Preencha o login inválido
    Input Text    ${input_name}    standard

Preencha a senha válida
    Input Text    ${input_password}    secret_sauce

Preencha a senha inválida
    Input Text    ${input_password}    secret_invalid

Click no botão login
    Click Element    ${button_submit}

Espere até a main page carregar
    Sleep    3s
    Wait Until Page Contains    Products

Espere até a mensagem login inválido
    Sleep    3s
    Wait Until Page Contains    Epic sadface

Espere até a mensagem Username is required
    Sleep    3s
    Wait Until Page Contains    Username is required

Selecione o item backpack
    Click Element    xpath:/html/body/div[1]/div/div/div[2]/div/div/div/div[1]/div[2]/div[1]/a/div

*** Test Cases ***
TC01: Login com nome de usuário válido
    Acesse o site Saucedemo
    Preencha o login válido
    Preencha a senha válida
    Click no botão login
    Espere até a main page carregar
    Fechar navegador

TC02: Login com senha inválida
    Acesse o site Saucedemo
    Preencha o login inválido
    Preencha a senha inválida
    Click no botão login
    Espere até a mensagem login inválido
    Fechar navegador

TC03: Login com campos vazios
    Acesse o site Saucedemo
    Click no botão login
    Espere até a mensagem Username is required
    Fechar navegador

### Casos de Teste Funcionais
TC04: Adicionar Produto ao Carrinho
    Acesse o site Saucedemo
    Faça o login
    Selecione o item backpack
    Fechar navegador