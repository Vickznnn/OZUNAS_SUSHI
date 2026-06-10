CREATE DATABASE IF NOT EXISTS ozunas_sushi
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

USE ozunas_sushi;

CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(160) NOT NULL UNIQUE,
    senha VARCHAR(120) NOT NULL,
    perfil ENUM('USUARIO', 'ADMIN') NOT NULL DEFAULT 'USUARIO',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cardapio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(80) NOT NULL,
    imagem_url VARCHAR(500),
    destaque BOOLEAN NOT NULL DEFAULT FALSE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nome, email, senha, perfil)
VALUES
    ('Administrador Ozunas', 'admin@ozunas.com', 'admin123', 'ADMIN'),
    ('Cliente Teste', 'cliente@ozunas.com', 'cliente123', 'USUARIO')
ON DUPLICATE KEY UPDATE
    nome = VALUES(nome),
    senha = VALUES(senha),
    perfil = VALUES(perfil);

INSERT INTO cardapio (nome, descricao, preco, categoria, imagem_url, destaque)
VALUES
    ('Combo Ozunas 24 peças', 'Escolha: salmão, kani, skin, uramaki e niguiri.', 29.90, 'Combinados', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/ozunas-sushi-padrao.jpg', TRUE),
    ('Temaki Salmão', 'Cone de alga crocante com arroz, salmão fresco, cream cheese(opcional) e cebolinha. Sabores: Atum, Salmão e Vegetariano.', 25.90, 'Temakis', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/tamaki-salmao-philadelphia.jpg', TRUE),
    ('Hot Roll Especial', 'Hot roll empanado com salmão, cream cheese e molho tarê.', 34.90, 'Hot Rolls', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/hot-roll-especial.jpg', FALSE),
    ('Sunomono', 'Pepino agridoce com gergelim, leve e refrescante.', 8.90, 'Entradas', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/sunomono.jpg', FALSE),
    ('Barca Família', 'Seleção com 60 peças para compartilhar.', 100.90, 'Combinados', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/barca-familia.jpg', TRUE),
    ('Uramaki', ' O clássico campeão de vendas! Enrolado de arroz japonês coberto com gergelim torrado, recheado com salmão fresco em cubos. Sabores: Salmão, Atum, Vegetariano, Salmão Grelhado e Skin,', 25,90, 'Uramakis', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/uramaki.jpeg', TRUE),
    ('Hossomaki', ' "O clássico e delicado enrolado de alga nori com recheio de salmão fresco e arroz temperado. Uma explosão de sabor na medida certa. Sabores: Salmão, Atum e Vegetariano.', 15.90, 'Hossomakis', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/hossomaki.jpg', FALSE);

    SELECT * FROM cardapio;
    SELECT * FROM usuarios;
-- ============================================================
-- ADICIONE MAIS OPÇÕES DO CARDÁPIO AQUI, SE QUISER PELO BANCO:
--
-- INSERT INTO cardapio (nome, descricao, preco, categoria, imagem_url, destaque)
-- VALUES ('Nome do prato', 'Descrição do prato', 00.00, 'Categoria', 'URL da imagem', FALSE);
--
-- Você também pode adicionar novos pratos pelo painel ADM do site.
-- ============================================================
