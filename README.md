# TheMarvels

## Descrição do Projeto

Este é um aplicativo simples de lista de super heróis da Marvel que utiliza a arquitetura MVVM em SwiftUI. Ele consome dados de um serviço da API para exibir informações sobre os personagens.

## Arquitetura

O projeto segue a arquitetura MVVM (Model-View-ViewModel), onde:

ContentView é a View principal.
CharactersViewModel é o ViewModel responsável pela lógica de apresentação da lista de personagens.
CharacterDetailViewModel é o ViewModel responsável pela lógica de apresentação da tela de detalhes dos personagens.
MarvelService é o serviço para interação com a API de personagens da Marvel.

## Funcionalidades

• Listagem dos personagens.

• Botão para favoritar nas células.

• Barra de busca para filtrar lista de personagens por nome.


- Exibição da lista de personagens da Marvel
- Exibição de lista de personagens favoritos 
- Detalhes de cada personagem, incluindo uma imagem, nome e descrição.
- Pesquisa de personagens por nome

## Configuração

Certifique-se de instalar as dependências usando o CocoaPods antes de executar o aplicativo.

1. Abra um terminal e navegue até o diretório do projeto.

2. Execute o comando:

`pod install`

Certifique-se de que você possui o CocoaPods instalado em seu sistema. Se não tiver, você pode instalá-lo usando:

`sudo gem install cocoapods`

## Dependências

O projeto utiliza o framework MarvelService para interagir com a API de personagens da Marvel.

## Como Executar o Projeto

1. Clone o repositório.
2. Abra o projeto no Xcode.
3. Execute o aplicativo em um simulador ou dispositivo.

## Requisitos do Sistema
- iOS 14.0+
- Xcode 12.0+

## Autor

Neto Moura

## Licença

Este projeto está sob a licença de Neto Moura.

---
