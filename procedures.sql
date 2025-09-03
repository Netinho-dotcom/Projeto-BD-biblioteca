CREATE PROCEDURE cadastrar_usuario(p_nome_usuario VARCHAR(40))
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO usuario(nome)
	VALUES(p_nome_usuario);
END;
$$;

CALL cadastrar_usuario('Geraldo');
SELECT*FROM usuario;

CREATE PROCEDURE cadastrar_livro(
p_titulo_livro VARCHAR(100),
p_id_autor INT,
p_ano_publicacao INT,
p_nome_autor VARCHAR (40))
LANGUAGE plpgsql
AS $$
BEGIN
	IF NOT EXISTS (SELECT 1 FROM autor WHERE id = p_id_autor) THEN
		INSERT INTO autor (id, nome)
		VALUES(p_id_autor, p_nome_autor);
	END IF;
	
	INSERT INTO livro (titulo, id_autor,ano_publicacao)
	VALUES(p_titulo_livro, p_id_autor, p_ano_publicacao);
END;
$$;

SELECT*FROM livro;
SELECT*FROM emprestimo;

CREATE PROCEDURE registrar_devolucao (
p_id_emprestimo INT,
p_data_devolucao DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE emprestimo 
	SET data_devolucao = p_data_devolucao
	WHERE emprestimo.id= p_id_emprestimo;
END;
$$;
DROP procedure registrar_devolucao;
CALL registrar_devolucao(2,'2025-08-25');

CREATE PROCEDURE excluir_usuario(p_id_usuario INT)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM emprestimo 
	WHERE id_usuario = p_id_usuario;
	DELETE FROM usuario
	WHERE id=p_id_usuario;
END;
$$;
CALL excluir_usuario(5);

select * from usuario;