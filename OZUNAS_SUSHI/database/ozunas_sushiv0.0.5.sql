-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 10/06/2026 às 18:15
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ozunas_sushi`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cardapio`
--

CREATE TABLE `cardapio` (
  `id` int(11) NOT NULL,
  `nome` varchar(120) NOT NULL,
  `descricao` text NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `categoria` varchar(80) NOT NULL,
  `imagem_url` varchar(500) DEFAULT NULL,
  `destaque` tinyint(1) NOT NULL DEFAULT 0,
  `ativo` tinyint(1) NOT NULL DEFAULT 1,
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `cardapio`
--

INSERT INTO `cardapio` (`id`, `nome`, `descricao`, `preco`, `categoria`, `imagem_url`, `destaque`, `ativo`, `criado_em`) VALUES
(8, 'Combo Ozunas 24 peças', 'Escolha: salmão, kani, skin, uramaki e niguiri.', 79.90, 'Combinados', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/ozunas-sushi-padrao.jpg', 1, 1, '2026-06-10 02:57:11'),
(9, 'Temaki Salmão', 'Cone de alga crocante com arroz, salmão fresco, cream cheese(opcional) e cebolinha. Sabores: Atum, Salmão e Vegetariano.', 28.90, 'Temakis', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/tamaki-salmao-philadelphia.jpg', 1, 1, '2026-06-10 02:57:11'),
(10, 'Hot Roll Especial', 'Hot roll empanado com salmão, cream cheese e molho tarê.', 34.90, 'Hot Rolls', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/hot-roll-especial.jpg', 0, 1, '2026-06-10 02:57:11'),
(11, 'Sunomono', 'Pepino agridoce com gergelim, leve e refrescante.', 16.90, 'Entradas', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/sunomono.jpg', 0, 1, '2026-06-10 02:57:11'),
(12, 'Barca Família', 'Seleção com 60 peças para compartilhar.', 169.90, 'Combinados', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/barca-familia.jpg', 1, 1, '2026-06-10 02:57:11'),
(13, 'Uramaki', 'O clássico campeão de vendas! Enrolado de arroz japonês coberto com gergelim torrado, recheado com salmão fresco em cubos. Sabores: Salmão, Atum, Vegetariano, Salmão Grelhado e Skin.', 25.90, 'Uramakis', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/uramaki.jpeg', 1, 1, '2026-06-10 16:08:33'),
(14, 'Hossomaki', 'O clássico e delicado enrolado de alga nori com recheio de salmão fresco e arroz temperado. Uma explosão de sabor na medida certa. Sabores: Salmão, Atum e Vegetariano.', 15.90, 'Hossomakis', 'https://raw.githubusercontent.com/Vickznnn/OZUNAS_SUSHI/refs/heads/main/OZUNAS_SUSHI/src/main/img/img-cardapio/hossomaki.jpg', 0, 1, '2026-06-10 16:10:01');

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(120) NOT NULL,
  `email` varchar(160) NOT NULL,
  `senha` varchar(120) NOT NULL,
  `perfil` enum('USUARIO','ADMIN') NOT NULL DEFAULT 'USUARIO',
  `criado_em` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `perfil`, `criado_em`) VALUES
(1, 'Administrador Ozunas', 'admin@ozunas.com', 'admin123', 'ADMIN', '2026-06-09 01:55:28'),
(2, 'Cliente Teste', 'cliente@ozunas.com', 'cliente123', 'USUARIO', '2026-06-09 01:55:28');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cardapio`
--
ALTER TABLE `cardapio`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cardapio`
--
ALTER TABLE `cardapio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
