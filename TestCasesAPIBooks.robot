*** Settings ***
Documentation   Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Resource        ResourceAPI.robot 
Suite Setup     Conectar a minha API


*** Test Cases ***
Cadastrar um novo livro (POST)
   Cadastrar um novo livro
#    Conferir se retorna todos os dados cadastrados para o novo livro    

Buscar um livro específico (GET em um livro específico)
    Requisitar o livro
#    Conferir o status code     [200]
#    Conferir o reason     OK
#    Conferir se retorna todos os dados corretos do livro 15


Alterar um livro (PUT)
    Alterar o livro  
#   - Conferir se retorna todos os dados alterados do libro 150
Deletar um livro (DELETE)
#   - Conferir se deleta o livro 200
