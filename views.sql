CREATE VIEW livros_com_autores AS
SELECT l.titulo AS livro, a.nome AS autor
FROM livro l 
JOIN autor a ON l.id_autor= a.id;


CREATE VIEW usuarios_com_emprestimos AS
SELECT u.nome AS usuario, l.titulo AS livro
FROM emprestimo e 
JOIN usuario u ON e.id_usuario = u.id 
JOIN livro l ON e.id_livro = l.id;

CREATE VIEW emprestimos_em_aberto AS
SELECT * FROM emprestimo 
WHERE data_devolucao IS NULL;


CREATE VIEW historico_emprestimos AS
SELECT u.nome AS usuario, l.titulo AS livros, a.nome AS autor, data_devolucao
FROM emprestimo e 
JOIN usuario u ON e.id_usuario = u.id
JOIN livro l ON e.id_livro = l.id
JOIN autor a ON l.id_autor= a.id;


CREATE VIEW qtd_emprestimos_por_usuario AS 
SELECT u.nome AS usario, COUNT(e.id_usuario) AS qtd_emprestimos
FROM usuario u 
JOIN emprestimo e ON u.id = e.id_usuario
GROUP BY u.nome;


CREATE VIEW livros_mais_recentes AS
SELECT l.titulo AS livros, a.nome AS autor
FROM livro l 
JOIN autor a ON l.id_autor = a.id
WHERE l.ano_publicacao > 1950;

CREATE VIEW usuarios_com_mais_de_um_emprestimo AS
SELECT u.*, COUNT(e.id_usuario) AS qtd_emprestimos FROM usuario u 
JOIN emprestimo e ON u.id = e.id_usuario
GROUP BY u.id
HAVING COUNT(e.id_usuario) > 1;