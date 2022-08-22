*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Library         RequestsLibrary
Library         Collections
Library         SeleniumLibrary
Library         json
Library         DateTime
Library         OperatingSystem


*** Variables ***
${URL_API}      http://fakerestapi.azurewebsites.net/api/v1/


*** Keywords ***
####SETUP E TEARDOWNS
Conectar a minha API
    Create Session        fakeAPI     ${URL_API}         

#### Ações
Cadastrar um novo livro
    Criando o arquivo json
    #Log to Console   ${id_livro}    
    ${livro}      Get File     C:\\Automação\\BooksAPI\\livro.json
    Set Suite Variable     ${livro}
    Log to Console   \n===========================================================
    Log to Console  \n..Livro Inserido:
    Log to Console   ${livro}
    Log to Console   ===========================================================\n
    &{HEADERS}=      Create Dictionary            Content-Type=application/json
    ${RESPOSTA}=     POST ON Session     fakeAPI     Books     data=${livro}     headers=${HEADERS}
    Set Variable      ${RESPOSTA.json()}
    #Log to Console    ...${RESPOSTA}

    Should Be True    '${RESPOSTA.status_code}' == '200'
    Log to Console    ...Validando Status Code: ${RESPOSTA.status_code}
    Should Be True    '${RESPOSTA.reason}' == 'OK'
    Log to Console    ...Validando Reason: ${RESPOSTA.reason}\n
    Log to Console   ===========================================================\n
    
Requisitar o livro    
    &{HEADERS1}=     Create Dictionary            Content-Type=application/json
    #${RESPOSTA1}=     GET On Session     fakeAPI     Books/${id_livro}     headers=${HEADERS1}
    ${RESPOSTA1}=     GET On Session     fakeAPI     Books/2     headers=${HEADERS1}
    Log to Console         ${RESPOSTA1.json()}
    Set Variable      ${RESPOSTA1}
    #Log to Console   ...Livro a ser pesquisado: ${id_livro}
    Log to Console   ...Livro a ser pesquisado: 2
    ${id}=          Get From Dictionary    ${RESPOSTA1.json()}   id
    ${titulo}=      Get From Dictionary    ${RESPOSTA1.json()}   title
    ${descricao}=   Get From Dictionary    ${RESPOSTA1.json()}   description
    ${paginas}=     Get From Dictionary    ${RESPOSTA1.json()}   pageCount
    ${excecao}=     Get From Dictionary    ${RESPOSTA1.json()}   excerpt
    ${datapub}=     Get From Dictionary    ${RESPOSTA1.json()}   publishDate

    Log to Console   \n===========================================================
    Set Suite Variable    ${id}
    Log to Console    ...ID: ${id}
    Set Suite Variable    ${titulo}
    Log to Console    ...Titulo: ${titulo}
    Set Suite Variable    ${descricao}
    Log to Console    ...Descrção: ${descricao}
    Set Suite Variable    ${paginas}
    Log to Console    ...Quant. Páginas: ${paginas}   
    Set Suite Variable    ${datapub}
    Log to Console    ...Data Publiucação: ${datapub}       
    Log to Console   ============================================================
    

Alterar o livro    
    &{HEADERS1}=     Create Dictionary            Content-Type=application/json
    #${RESPOSTA1}=     Put Request      fakeAPI     Books/${id_livro}     headers=${HEADERS1}
    ${RESPOSTA1}=     Put Request     fakeAPI     Books/2     headers=${HEADERS1}
    Log to Console         ${RESPOSTA1.json()}
    Set Variable      ${RESPOSTA1}
    #Log to Console   ...Livro a ser alterado: ${id_livro}
    Log to Console   ...Livro a ser alterado: 2
    ${id}=          Get From Dictionary    ${RESPOSTA1.json()}   id
    ${titulo}=      Get From Dictionary    ${RESPOSTA1.json()}   title
    ${descricao}=   Get From Dictionary    ${RESPOSTA1.json()}   description
    ${paginas}=     Get From Dictionary    ${RESPOSTA1.json()}   pageCount
    ${excecao}=     Get From Dictionary    ${RESPOSTA1.json()}   excerpt
    ${datapub}=     Get From Dictionary    ${RESPOSTA1.json()}   publishDate

    Log to Console   \n===========================================================
    Set Suite Variable    ${id}
    Log to Console    ...ID: ${id}
    Set Suite Variable    ${titulo}
    Log to Console    ...Titulo: ${titulo}
    Set Suite Variable    ${descricao}
    Log to Console    ...Descrção: ${descricao}
    Set Suite Variable    ${paginas}
    Log to Console    ...Quant. Páginas: ${paginas}   
    Set Suite Variable    ${datapub}
    Log to Console    ...Data Publiucação: ${datapub}       
    Log to Console   ============================================================




### Criando um arquivo com o id variável
Criando o arquivo json
    ${data} =  Get Current Date
    ${id_livro}=     Evaluate             random.randrange(1000, 9999)      random
    ${id_livro}=     Convert To String    ${id_livro}
    Set Suite Variable    ${id_livro}
    Log                   ${id_livro}

    Create File       C:\\Automação\\BooksAPI\\livro.json
    Append to File    C:\\Automação\\BooksAPI\\livro.json     {\n
    Append to File    C:\\Automação\\BooksAPI\\livro.json     "id": ${id_livro},\n
    Append to File    C:\\Automação\\BooksAPI\\livro.json     "title": "Teste ALE ${id_livro}",\n
    Append to File    C:\\Automação\\BooksAPI\\livro.json     "description": "Teste API ALE",\n
    Append to File    C:\\Automação\\BooksAPI\\livro.json     "pageCount": 211,\n
    Append to File    C:\\Automação\\BooksAPI\\livro.json     "excerpt": "AOL AOL AOL AOL",\n
    Append to File    C:\\Automação\\BooksAPI\\livro.json     "publishDate": "2022-08-22T18:37:45.379Z"\n
    Append to File    C:\\Automação\\BooksAPI\\livro.json     }
