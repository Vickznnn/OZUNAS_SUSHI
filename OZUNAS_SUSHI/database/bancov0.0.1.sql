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
    ('Combo Ozunas 24 peças', 'Salmão, kani, skin, uramaki e niguiris selecionados pela casa.', 79.90, 'Combinados', 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?auto=format&fit=crop&w=900&q=80', TRUE),
    ('Temaki Salmão Philadelphia', 'Cone de alga crocante com arroz, salmão fresco, cream cheese e cebolinha.', 28.90, 'Temakis', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/main/OZUNAS_SUSHI/src/main/img/tmaki-salmao-philadelphia.jpg', TRUE),
    ('Hot Roll Especial', 'Hot roll empanado com salmão, cream cheese e molho tarê.', 34.90, 'Hot Rolls', 'https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&w=900&q=80', FALSE),
    ('Sunomono', 'Pepino agridoce com gergelim, leve e refrescante.', 16.90, 'Entradas', 'https://images.unsplash.com/photo-1607301406259-dfb186e15de8?auto=format&fit=crop&w=900&q=80', FALSE),
    ('Barca Família', 'Seleção com 60 peças para compartilhar.', 169.90, 'Combinados', 'https://images.unsplash.com/photo-1553621042-f6e147245754?auto=format&fit=crop&w=900&q=80', TRUE);
    
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
