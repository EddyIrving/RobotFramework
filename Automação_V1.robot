*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  Collections
Library  PIL.Image
Library  RequestsLibrary
Library  image_comparator
Library  docx
#Library  cv2
#Library  OpenCV
#Library  skimage.metrics.structural_similarity
#Library  ImageHorizonLibrary



*** Variables ***
#### tela de login ####
${input_name}        id:user-name
${input_password}    id:password
${button_submit}     id:login-button
${button_add_to_cart}  id:add-to-cart

####################### pagina principal ###########################
${combobox_filtro}      xpath=//html/body/div[1]/div/div/div[1]/div[2]/div/span/select

${title_backpack}    id:item_4_title_link
${title_bike_light}   id:item_0_title_link
${title_bolt_t_shirt}   id:item_1_title_link
${title_fleece_jacket}   id:item_5_title_link
${title_onesie}   id:item_2_title_link
${title_allTheThings()}   id:item_3_title_link

${add_to_cart_backpack_main_page}    id:add-to-cart-sauce-labs-backpack
${add_to_cart_bike_light_main_page}    id:add-to-cart-sauce-labs-bike-light
${add_to_cart_bolt_t_shirt_main_page}    id:add-to-cart-sauce-labs-bolt-t-shirt
${add_to_cart_fleece_jacket_main_page}    id:add-to-cart-sauce-labs-fleece-jacket
${add_to_cart_labs_onesie_main_page}    id:add-to-cart-sauce-labs-onesie
${add_to_cart_allthethings()_main_page}    id:add-to-cart-test.allthethings()-t-shirt-(red)

${remove_to_cart_backpack_main_page}  id:remove-sauce-labs-backpack
${remove_to_cart_bike_light_main_page}  id:remove-sauce-labs-bike-light
${remove_to_cart_bolt_t_shirt_main_page}  id:remove-sauce-labs-bolt-t-shirt
${remove_to_cart_fleece_jacket_main_page}  id:remove-sauce-labs-fleece-jacket
${remove_to_cart_onesie_main_page}  id:remove-sauce-labs-onesie
${remove_to_cart_allthethings()_main_page}  id:remove-sauce-labs-onesie

###################### pagina carrinho ###############################

${icon_cart}         id:shopping_cart_container
${button_continue_shopping}     id:continue-shopping

###################### Imagens para validação ###########################
${PASTA_IMAGENS}       imagens_referencia
${IMAGEM_SELETORES}     //img[@class="inventory_item_img"]
${PASTA_ATUAL}         imagens_do_teste_atual
${PASTA_REFERENCIA}    imagens_referencia

#${imagen_back_pack}     xpath=//html/body/div[1]/div/div/div[2]/div/div/div[1]/img
#${imagen_bike_light}    xpath=//html/body/div[1]/div/div/div[2]/div/div/div/div[2]/div[1]/a/img
#${imagen_t_shirt}       xpath=//html/body/div[1]/div/div/div[2]/div/div/div/div[3]/div[1]/a/img
#${imagen_fleece_jacket}    xpath=//html/body/div[1]/div/div/div[2]/div/div/div/div[4]/div[1]/a/img
#${imagen_onesie}        xpath=//html/body/div[1]/div/div/div[2]/div/div/div/div[5]/div[1]/a/img
#${imagen_allthethings()}    xpath=//html/body/div[1]/div/div/div[2]/div/div/div/div[6]/div[1]/a/img

#${valor_contador_icone_cart}
#${valor_contador_adiconar_ou_remover_item}  0
#${valor_contador}    xpath=//data-test="shopping-cart-badge"
#########################################################################################################
*** Keywords ***
Acesse o site Robot
    Open Browser    http://Robotframework.org/    firefox
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
Preencha o login válido
    Input Text    ${input_name}    standard_user
Preencha o login inválido
    Input Text    ${input_name}    standard
Preencha a senha válida
    Input Text    ${input_password}    secret_sauce
Preencha a senha inválida
    Input Text    ${input_password}    secret_invalid
Preencha o login locked_out_user
    Input Text    ${input_password}    locked_out_user
Preencha o login problem_user
    Input Text    ${input_password}    problem_user
Preencha o login performance_glitch_user
    Input Text    ${input_password}    performance_glitch_user
Preencha o login error_user
    Input Text    ${input_password}    error_user
Preencha o login visual_user
    Input Text    ${input_password}    visual_user





Click no botão login
    Click Element    ${button_submit}
Espere até a mensagem login inválido
    Sleep    3s
    Wait Until Page Contains    Username and password do not match any user in this service
Espere até a mensagem Username is required
    Sleep    3s
    Wait Until Page Contains    Username is required
Espere até a mensagem Username is required
    Sleep    3s
    Wait Until Page Contains    Password is required

Espere até a main page carregar
    Sleep    3s
    Wait Until Page Contains    Products

Espere até a mensagem locked_out
    Sleep    3s
    Wait Until Page Contains    Epic sadface: Sorry, this user has been locked out.
#######################

######### Filtros main page ##########

Altere o filtro para (Z to A)
    Click element    ${combobox_filtro}
    Select from list by label   ${combobox_filtro}      Name (Z to A)
    Sleep    2s
Altere o filtro para (A to Z)
    Click element    ${combobox_filtro}
    Select from list by label   ${combobox_filtro}      Name (A to Z)
    Sleep    2s
Altere o filtro para (low to high)
    Click element    ${combobox_filtro}
    Select from list by label   ${combobox_filtro}      Price (low to high)
    Sleep    2s
Altere o filtro para (high to low)
    Click element    ${combobox_filtro}
    Select from list by label   ${combobox_filtro}      Price (high to low)
    Sleep    2s
########        titulos       ##########
Selecione o item backpack
    Wait until element is visible   ${title_backpack}
    Click Element    ${title_backpack}
    Sleep    1s
Selecione o item bike light
    Wait until element is visible    ${title_bike_light}
    Click Element    ${title_bike_light}
    Sleep    1s
Selecione o item bolt t-shirt
    Wait until element is visible    ${title_bolt_t_shirt}
    Click Element    ${title_bolt_t_shirt}
    Sleep    1s
Selecione o item fleece jacket
    Wait until element is visible    ${title_fleece_jacket}
    Click Element    ${title_fleece_jacket}
    Sleep    1s
Selecione o item onesie
    Wait until element is visible    ${title_onesie}
    Click Element    ${title_onesie}
    Sleep    1s
Selecione o item all The Things()
    Wait until element is visible    ${title_allTheThings()}
    Click Element    ${title_allTheThings()}
    Sleep    1s
############ Adicionar no carrinho #################
Clique no botao "Add to cart" da backpack
    Wait until element is visible    ${add_to_cart_backpack_main_page}
    Click element    ${add_to_cart_backpack_main_page}
Clique no botao "Add to cart" da bike light
    Wait until element is visible    ${add_to_cart_bike_light_main_page}
    Click element    ${add_to_cart_bike_light_main_page}
Clique no botao "Add to cart" da t shirt
    Wait until element is visible    ${add_to_cart_bolt_t_shirt_main_page}
    Click element    ${add_to_cart_bolt_t_shirt_main_page}
Clique no botao "Add to cart" da fleece jacket
    Wait until element is visible    ${add_to_cart_fleece_jacket_main_page}
    Click element    ${add_to_cart_fleece_jacket_main_page}
Clique no botao "Add to cart" da onesie
    Wait until element is visible    ${add_to_cart_labs_onesie_main_page}
    Click element    ${add_to_cart_labs_onesie_main_page}
Clique no botao "Add to cart" da allthethings
    Wait until element is visible    ${add_to_cart_allthethings()_main_page}
    Click element    ${add_to_cart_allthethings()_main_page}
############# Remover do carrinho #############
Clique no botao "Remove to cart" da backpack
  Wait until element is visible    ${remove_to_cart_backpack_main_page}
    Click element    ${remove_to_cart_backpack_main_page}
Clique no botao "Remove to cart" da bike light
    Wait until element is visible   ${remove_to_cart_bike_light_main_page}
    Click element   ${remove_to_cart_bike_light_main_page}
Clique no botao "Remove to cart" da t shirt
    Wait until element is visible    ${remove_to_cart_bolt_t_shirt_main_page}
    Click element    ${remove_to_cart_bolt_t_shirt_main_page}
Clique no botao "Remove to cart" da fleece jacket
    Wait until element is visible    ${remove_to_cart_fleece_jacket_main_page}
    Click element    ${remove_to_cart_fleece_jacket_main_page}
Clique no botao "Remove to cart" da onesie
    Wait until element is visible    ${remove_to_cart_onesie_main_page}
    Click element    ${remove_to_cart_onesie_main_page}
Clique no botao "Remove to cart" da allthethings
    Wait until element is visible    ${remove_to_cart_allthethings()_main_page}
    Click element   ${remove_to_cart_allthethings()_main_page}
Clique no botão "ADD TO CART"
    Wait until element is visible    ${button_add_to_cart}
    Click element   ${button_add_to_cart}
Clique no carrinho
    Wait until element is visible    ${icon_cart}
    Click element    ${icon_cart}
Clique no botao Continue Shopping
    Wait until element is visible    ${button_continue_shopping}
    Click element    ${button_continue_shopping}
    Sleep    1s
############ Validação titulos aparecendo##########
O item backpack deve aparecer no cart
    Wait until element is visible   ${title_backpack}
O item bike light deve aparecer no cart
    Wait until element is visible    ${title_bike_light}
O item bolt t-shirt deve aparecer no cart
    Wait until element is visible    ${title_bolt_t_shirt}
O item fleece jacket deve aparecer no cart
    Wait until element is visible    ${title_fleece_jacket}
O item onesie deve aparecer no cart
    Wait until element is visible    ${title_onesie}
O item all The Things() deve aparecer no cart
    Wait until element is visible    ${title_allTheThings()}

############ Validação das imagens

Baixar Imagem
    [Arguments]    ${url}    ${caminho}
    ${response}    GET    ${url}
    Create Binary File    ${caminho}    ${response.content}

Comparar Imagem
    [Arguments]    ${imagem_ref}    ${imagem_atual}
    ${resultado}    Compare Images    ${imagem_ref}    ${imagem_atual}
    Run Keyword If    ${resultado}==False    Fail    A imagem mudou: ${imagem_atual}


Validar se as Imagens dos Itens carregaram corretamente
    Wait Until Element Is Visible    //img[@class="inventory_item_img"]    timeout=10s
    @{imagens}    Get WebElements    //img[@class="inventory_item_img"]


    ${qtd_imagens}    Get Length    ${imagens}
    Should Be Equal As Numbers    ${qtd_imagens}    6    # Verifica se há 6 imagens

    FOR    ${img}    IN    @{imagens}
        ${src}    Get Element Attribute    ${img}    src
        Should Not Be Empty    ${src}    # Verifica se a URL da imagem não está vazia
        ${response}    GET    ${src}
        Should Be Equal As Numbers    ${response.status_code}    200    # Verifica se a imagem carregou corretamente
    END
    Close Browser

Coletar Imagens dos produtos
    [Documentation]    Captura as imagens dos itens e salva localmente
    Wait Until Element Is Visible    ${IMAGEM_SELETORES}
    # Criar a pasta se não existir
    Create Directory    ${PASTA_IMAGENS}
    ${imagens}    Get WebElements    ${IMAGEM_SELETORES}
    ${indice}    Set Variable    1
    FOR    ${imagem}    IN    @{imagens}
        ${src}    Get Element Attribute    ${imagem}    src
        ${caminho_arquivo}    Set Variable    ${PASTA_IMAGENS}/imagem_${indice}.jpg
        Baixar Imagem    ${src}    ${caminho_arquivo}
        ${indice}    Evaluate    ${indice} + 1
    END
    Close Browser


Comparar Imagens da Página com as Referências
    [Documentation]    Verifica se as imagens da página são as mesmas da base de referência
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



#########################################################
###########
#Validação icone cart
#    Get text    ${valor_contador}
#    Log         ${valor_contador_icone_cart}
#    Should be equal    ${valor_contador_icone_cart}     ${valor_contador_adiconar_ou_remover_item}

*** Test Cases ***


#### tela login ####
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

TC02: Login com nome de usuário problem_user
    Acesse o site Saucedemo
    Preencha o login problem_user
    Preencha a senha válida
    Click no botão login

    Fechar navegador

TC02: Login com nome de usuário locked_out_user
    Acesse o site Saucedemo
    Preencha o login locked_out_user
    Preencha a senha válida
    Click no botão login

    Fechar navegador

TC02: Login com nome de usuário performance_glitch_user
    Acesse o site Saucedemo
    Preencha o login performance_glitch_user
    Preencha a senha válida
    Click no botão login

    Fechar navegador
TC02: Login com nome de usuário error_user
    Acesse o site Saucedemo
    Preencha o login error_user
    Preencha a senha válida
    Click no botão login

    Fechar navegador
TC02: Login com nome de usuário visual_user
    Acesse o site Saucedemo
    Preencha o login visual_user
    Preencha a senha válida
    Click no botão login

    Fechar navegador









TC03: Login com campos vazios
    Acesse o site Saucedemo
    Click no botão login
    Espere até a mensagem Username is required
    Fechar navegador
#### Casos de Teste Funcionais ####
TC04: Adicionar a um item ao Carrinho
    Acesse o site Saucedemo
    Faça o login
    Selecione o item backpack
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item backpack deve aparecer no cart
#    Validação icone cart
    Fechar navegador
TC05: Adicionar segundo item cart
    Acesse o site Saucedemo
    Faça o login
    Altere o filtro para (Z to A)
    Selecione o item backpack
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item backpack deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Selecione o item bike light
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item bike light deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
#    Validação icone cart
    Fechar navegador
TC06: Adicionar terceiro item cart
    Acesse o site Saucedemo
    Faça o login
    Selecione o item backpack
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item backpack deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Selecione o item bike light
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item bike light deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Selecione o item bolt t-shirt
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item bolt t-shirt deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
#    Validação icone cart
    Fechar navegador
TC07: Remover Produto do Carrinho
    Acesse o site Saucedemo
    Faça o login
    Clique no botao "Add to cart" da backpack
    Clique no carrinho
    O item backpack deve aparecer no cart
    Clique no botao "Remove to cart" da backpack
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Clique no botao "Add to cart" da bike light
    Clique no carrinho
    O item bike light deve aparecer no cart
    Clique no botao "Remove to cart" da bike light
    Clique no botao Continue Shopping
    Espere até a main page carregar
TC08: Filtrar Produtos por Nome (Z to A)
    Acesse o site Saucedemo
    Faça o login
    Altere o filtro para (Z to A)
    Selecione o item backpack
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item backpack deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Fechar navegador
TC09: Filtrar Produtos por Nome (A to Z)
    Acesse o site Saucedemo
    Faça o login
    Altere o filtro para (Z to A)
    Altere o filtro para (A to Z)
    Selecione o item backpack
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item backpack deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Fechar navegador
TC10: Filtrar Produtos por Nome (low to high)
    Acesse o site Saucedemo
    Faça o login
    Altere o filtro para (low to high)
    Selecione o item backpack
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item backpack deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Fechar navegador
TC11: Filtrar Produtos por Nome (high to low)
    Acesse o site Saucedemo
    Faça o login
    Altere o filtro para (high to low)
    Selecione o item backpack
    Clique no botão "ADD TO CART"
    Clique no carrinho
    O item backpack deve aparecer no cart
    Clique no botao Continue Shopping
    Espere até a main page carregar
    Fechar navegador
###Casos de Teste validação de imagens
TC12: Verificar exibição de imagens dos produtos carregam corretamente
    Acesse o site Saucedemo
    Faça o login
    Validar se as Imagens dos Itens carregaram corretamente
    Fechar navegador
TC13: Coletar as imagens dos produtos para referencia de validação
    Acesse o site Saucedemo
    Faça o login
    Coletar Imagens dos produtos
    Fechar navegador
TC14: Comparar imagens atuais com as referencias
    Acesse o site Saucedemo
    Faça o login
    Comparar Imagens da Página com as Referências
#    Passos: Navegue pela página de inventário.
#    Resultado Esperado: Todas as imagens dos produtos devem ser exibidas corretamente.

Verificar Exibição de Descrições dos Produtos
    #Passos: Navegue pela página de inventário.
    #Resultado Esperado: Todas as descrições dos produtos devem ser exibidas corretamente.

Verificar Exibição de Preços dos Produtos
    #Passos: Navegue pela página de inventário.
    #Resultado Esperado: Todos os preços dos produtos devem ser exibidos corretamente.

###Casos de Teste de Segurança
Verificar Logout
    #Passos: Clique no botão "Logout".
    #Resultado Esperado: O usuário deve ser deslogado e redirecionado para a página de login.

Verificar Reset do Estado do Aplicativo
#    Passos: Clique no botão "Reset App State".
#    Resultado Esperado: O estado do aplicativo deve ser resetado, removendo todos os itens do carrinho e resetando os filtros.