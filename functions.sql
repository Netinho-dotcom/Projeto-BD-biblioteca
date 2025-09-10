CREATE FUNCTION autor_do_livro(p_id INT)
RETURNS TEXT AS $$
DECLARE
    v_autor TEXT;
BEGIN
    SELECT a.nome
    INTO v_autor
    FROM livro l
    JOIN autor a ON l.id = a.id
    WHERE l.id = p_id;

    RETURN v_autor;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION livro_emprestado(p_id INT)
RETURNS TEXT AS $$
DECLARE
    v_status TEXT;
BEGIN
    SELECT 
        CASE 
            WHEN e.data_devolucao IS NULL THEN 'Livro emprestado'
            ELSE 'Livro disponível'
        END
    INTO v_status
    FROM emprestimo e
    WHERE e.id = (
        SELECT MAX(id) FROM emprestimo WHERE id_livro = p_id
    );

    RETURN COALESCE(v_status, 'Livro disponível');
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION usuario_com_atraso(p_id INT)
RETURNS TEXT AS $$
DECLARE
    v_result TEXT;
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM emprestimo e
        WHERE e.id_usuario = p_id
        AND e.data_devolucao IS NULL
        AND CURRENT_DATE - e.data_emprestimo > 10
    ) THEN
        v_result := 'Usuário possui livros atrasados';
    ELSE
        v_result := 'Usuário em dia';
    END IF;

    RETURN v_result;
END;
$$ LANGUAGE plpgsql;


ALTER TABLE emprestimo ADD COLUMN valor NUMERIC(10,2);

-- Atualizando dados manualmente
UPDATE emprestimo SET valor = 5.00 WHERE id = 1;
UPDATE emprestimo SET valor = 7.50 WHERE id = 2;
UPDATE emprestimo SET valor = 6.00 WHERE id = 3;
UPDATE emprestimo SET valor = 4.50 WHERE id = 4;
UPDATE emprestimo SET valor = 8.00 WHERE id = 5;


CREATE FUNCTION total_gasto_usuario(p_id INT)
RETURNS NUMERIC(10,2) AS $$
DECLARE
    v_total NUMERIC(10,2);
BEGIN
    SELECT COALESCE(SUM(valor), 0)
    INTO v_total
    FROM emprestimo
    WHERE id_usuario = p_id;

    RETURN v_total;
END;
$$ LANGUAGE plpgsql;