USE ozunas_sushi;

INSERT INTO usuarios (nome, email, senha, perfil)
VALUES
    ('Administrador Ozunas', 'admin@ozunas.com', 'admin123', 'ADMIN'),
    ('Cliente Teste', 'cliente@ozunas.com', 'cliente123', 'USUARIO')
ON DUPLICATE KEY UPDATE
    nome = VALUES(nome),
    senha = VALUES(senha),
    perfil = VALUES(perfil);

SELECT id, nome, email, senha, perfil FROM usuarios;
