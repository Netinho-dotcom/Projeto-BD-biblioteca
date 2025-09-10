--consultando views

SELECT * FROM livros_com_autores;

SELECT * FROM usuarios_com_emprestimos;

SELECT * FROM emprestimos_em_aberto;

SELECT * FROM historico_emprestimos;

SELECT * FROM qtd_emprestimos_por_usuario;

SELECT * FROM livros_mais_recentes;

SELECT * FROM usuarios_com_mais_de_um_emprestimo;

-- chamando procedures

CALL cadastrar_usuario('Geraldo');
SELECT*FROM usuario;

CALL cadastrar_livro('Crime e Castigo', 7, 1886, 'Fiodor Dostoievski');
SELECT*FROM livro;


CALL registrar_devolucao(3,'2025-08-31');
SELECT*FROM emprestimo;

--criando emprestimo no nome do usuario Geraldo para testar a procedure
INSERT INTO emprestimo (id,id_usuario,id_livro,data_emprestimo,data_devolucao)
VALUES(6,6,8,'2025-08-07','2025-08-24');

CALL excluir_usuario(6);
SELECT*FROM emprestimo;
SELECT*FROM usuario;


--consultando function

SELECT autor_do_livro(1);

SELECT livro_emprestado(2);

SELECT usuario_com_atraso(3);

SELECT total_gasto_usuario(4);