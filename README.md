# APOD NASA API Flutter App

Este projeto é um aplicativo Flutter que consome a API Astronomy Picture of the Day (APOD) da NASA. Ele exibe a imagem astronômica do dia, juntamente com uma breve descrição fornecida pela NASA. O objetivo é proporcionar aos usuários uma maneira fácil e interativa de explorar e aprender sobre o universo através das imagens diárias selecionadas pela NASA.

## Estrutura de Microapps e Arquitetura

### Estrutura de Microapps

O projeto é organizado em microapps, onde cada funcionalidade principal do aplicativo é desenvolvida como um módulo independente. Isso facilita a manutenção, escalabilidade e testes isolados de cada parte do aplicativo. Cada microapp contém suas próprias camadas de apresentação, domínio e dados.

```
|-- main
|-- commons
|-- core
|-- modules
    |-- home
    |-- media
```

- **main**: package principal do projeto
- **commons**: package de recursos independentes do negócio, dependencies, wrapes, henpers genéricos, environment, integraççoes etc
- **core**: package de recursos compartilhados que fazem parte do core de negócio abordadop pelo app
- **modules**: packages das jornadas de negócio

### Arquitetura Baseada em Clean Architecture

A arquitetura do projeto segue os princípios da Clean Architecture, que promove a separação de responsabilidades em diferentes camadas. As camadas principais são:

- **Camada de Apresentação**: Contém a interface do usuário e a lógica de apresentação. Utiliza o padrão MVVM (Model-View-ViewModel) para gerenciar o estado da UI.
- **Camada de Domínio**: Contém as regras de negócio e casos de uso. É independente de frameworks e bibliotecas externas.
- **Camada de Dados**: Responsável pela obtenção de dados, seja de APIs, bancos de dados locais ou outras fontes. Implementa repositórios que fornecem dados para a camada de domínio.

### Princípios SOLID

O projeto adere aos princípios SOLID para garantir um código mais robusto e de fácil manutenção:

- **S**ingle Responsibility Principle (Princípio da Responsabilidade Única): Cada classe tem uma única responsabilidade.
- **O**pen/Closed Principle (Princípio do Aberto/Fechado): As classes são abertas para extensão, mas fechadas para modificação.
- **L**iskov Substitution Principle (Princípio da Substituição de Liskov): As subclasses devem ser substituíveis por suas superclasses.
- **I**nterface Segregation Principle (Princípio da Segregação de Interface): Muitas interfaces específicas são melhores do que uma interface única e geral.
- **D**ependency Inversion Principle (Princípio da Inversão de Dependência): Dependa de abstrações, não de implementações concretas.

Essa combinação de microapps, Clean Architecture e princípios SOLID resulta em um código modular, testável e fácil de manter.

## Recursos utilizados

### Flutter

Versão do Flutter: 3.29.1

Versão do dart: 3.7.0

### Melos

Melos é uma ferramenta de gerenciamento de pacotes para projetos Flutter e Dart que facilita o gerenciamento de múltiplos pacotes dentro de um único repositório (monorepo). Ele ajuda a automatizar tarefas comuns, como a publicação de pacotes, a execução de testes e a atualização de dependências, tornando o desenvolvimento mais eficiente e organizado.

Para instalar

`$ flutter pub add melos`

O projeto já está configurado para com os recursos do melos.

Após a instalação, para executar automaticamente o flutter pub get em todos os repositórios execute

`$ melos bs`
