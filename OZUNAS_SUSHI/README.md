# Ozunas Sushi

Projeto Java Web básico para um restaurante de sushi, com HTML, CSS, JavaScript, Java Servlet/JSP e MySQL.

## Tecnologias

- Java Amazon Corretto 16.0.2
- IntelliJ IDEA
- Maven
- Tomcat 9
- MySQL
- HTML, CSS e JavaScript

## Como abrir no IntelliJ

1. Abra esta pasta como projeto Maven no IntelliJ.
2. Configure o SDK do projeto como Amazon Corretto 16.0.2.
3. Instale/configure um servidor Tomcat 9 no IntelliJ.
4. No MySQL, execute o arquivo `database/ozunas_sushi.sql`.
5. Ajuste usuário e senha do banco em `src/main/java/com/ozunas/config/DatabaseConnection.java`.
6. Rode o projeto pelo Tomcat.
7. Acesse no navegador: `http://localhost:8080/ozunas-sushi/home`.

Se o IntelliJ pedir para baixar dependências Maven, aceite. O terminal desta máquina não tem Maven configurado, mas o IntelliJ geralmente usa o Maven interno sem problema.

## Acessos de teste

Cliente:

- E-mail: `cliente@ozunas.com`
- Senha: `cliente123`

Administrador:

- E-mail: `admin@ozunas.com`
- Senha: `admin123`

## Onde adicionar mais opções no cardápio

Você tem duas opções:

1. Pelo painel ADM do site: faça login como administrador e use a seção `ADICIONE MAIS OPÇÕES DO CARDÁPIO AQUI`.
2. Pelo banco de dados: edite o arquivo `database/ozunas_sushi.sql`, no bloco comentado no final do arquivo.

Exemplo:

```sql
INSERT INTO cardapio (nome, descricao, preco, categoria, imagem_url, destaque)
VALUES ('Joe de salmão', 'Bolinho de arroz envolto em salmão com cream cheese.', 32.90, 'Joes', 'https://...', TRUE);
```

## Observação importante

As senhas estão salvas como texto simples porque o objetivo é ser um exemplo básico para estudo. Em um sistema real, use criptografia de senha com BCrypt ou outra solução segura.
