USE gestao_restaurante;

-- =====================================================
-- 1. INSERCAO DOS DADOS DE TESTE
-- =====================================================

-- 1.1 CARGOS
INSERT INTO cargo (nome, descricao) VALUES
('Gerente', 'Responsavel pela gestao do restaurante'),
('Garcom', 'Responsavel pelo atendimento aos clientes'),
('Caixa', 'Responsavel pelos pagamentos');

-- 1.2 CLIENTES
INSERT INTO cliente (cpf, nome, telefone, endereco) VALUES
('11111111111', 'Carlos Silva', '61999990001', 'Rua A, Brasilia'),
('22222222222', 'Mariana Souza', '61999990002', 'Rua B, Brasilia'),
('33333333333', 'Pedro Santos', '61999990003', 'Rua C, Brasilia');

-- 1.3 MESAS
INSERT INTO mesa (numero, capacidade) VALUES
(1, 2),
(2, 4),
(3, 4),
(4, 6),
(5, 8);

-- 1.4 CATEGORIAS
INSERT INTO categoria (nome) VALUES
('Bebidas'),
('Pratos principais'),
('Sobremesas'),
('Entradas');

-- 1.5 FORMAS DE PAGAMENTO
INSERT INTO forma_pagamento (nome, descricao) VALUES
('Dinheiro', 'Pagamento em especie'),
('Pix', 'Pagamento por transferencia Pix'),
('Cartao de credito', 'Pagamento com cartao de credito'),
('Cartao de debito', 'Pagamento com cartao de debito');

-- 1.6 FORNECEDORES
INSERT INTO fornecedor (cnpj, nome, telefone) VALUES
('12345678000190', 'Distribuidora Central', '61333330001'),
('98765432000110', 'Fornecedor Alimentos', '61333330002'),
('45678912000155', 'Bebidas Brasil', '61333330003');

-- 1.7 FUNCIONARIOS
INSERT INTO funcionario
(cpf, nome, data_nasc, telefone, data_contratacao, id_cargo)
VALUES
('44444444444', 'Roberto Lima', '1985-04-12', '61988880001', '2024-01-10',
 (SELECT id_cargo FROM cargo WHERE nome = 'Gerente')),
('55555555555', 'Ana Oliveira', '1998-08-20', '61988880002', '2025-03-15',
 (SELECT id_cargo FROM cargo WHERE nome = 'Garcom')),
('66666666666', 'Lucas Ferreira', '1995-11-05', '61988880003', '2025-06-01',
 (SELECT id_cargo FROM cargo WHERE nome = 'Caixa'));

-- 1.8 PRODUTOS
INSERT INTO produto
(nome, descricao, ativo, estoque_minimo, quantidade, preco_venda, id_categoria)
VALUES
('Refrigerante', 'Refrigerante lata 350ml', 1, 10, 50, 6.00,
 (SELECT id_categoria FROM categoria WHERE nome = 'Bebidas')),
('Suco natural', 'Suco natural de laranja', 1, 5, 30, 8.00,
 (SELECT id_categoria FROM categoria WHERE nome = 'Bebidas')),
('Hamburguer', 'Hamburguer artesanal', 1, 5, 20, 25.00,
 (SELECT id_categoria FROM categoria WHERE nome = 'Pratos principais')),
('Pizza', 'Pizza media de mussarela', 1, 3, 15, 40.00,
 (SELECT id_categoria FROM categoria WHERE nome = 'Pratos principais')),
('Pudim', 'Pudim de leite condensado', 1, 5, 12, 10.00,
 (SELECT id_categoria FROM categoria WHERE nome = 'Sobremesas')),
('Batata frita', 'Porcao de batata frita', 1, 5, 25, 18.00,
 (SELECT id_categoria FROM categoria WHERE nome = 'Entradas'));

-- 1.9 FORNECEDOR_PRODUTO
INSERT INTO fornecedor_produto
(cnpj_fornecedor, id_produto, preco_compra)
VALUES
((SELECT cnpj FROM fornecedor WHERE nome = 'Distribuidora Central'),
 (SELECT id_produto FROM produto WHERE nome = 'Refrigerante'), 3.50),
((SELECT cnpj FROM fornecedor WHERE nome = 'Bebidas Brasil'),
 (SELECT id_produto FROM produto WHERE nome = 'Suco natural'), 4.00),
((SELECT cnpj FROM fornecedor WHERE nome = 'Fornecedor Alimentos'),
 (SELECT id_produto FROM produto WHERE nome = 'Hamburguer'), 12.00),
((SELECT cnpj FROM fornecedor WHERE nome = 'Fornecedor Alimentos'),
 (SELECT id_produto FROM produto WHERE nome = 'Pizza'), 20.00),
((SELECT cnpj FROM fornecedor WHERE nome = 'Fornecedor Alimentos'),
 (SELECT id_produto FROM produto WHERE nome = 'Pudim'), 5.00),
((SELECT cnpj FROM fornecedor WHERE nome = 'Fornecedor Alimentos'),
 (SELECT id_produto FROM produto WHERE nome = 'Batata frita'), 8.00);

-- 1.10 MOVIMENTACOES DE ESTOQUE
INSERT INTO movimentacao_estoque
(tipo, quantidade, data, id_produto, cpf_funcionario, cnpj_fornecedor)
VALUES
('Entrada', 20, '2026-11-10',
 (SELECT id_produto FROM produto WHERE nome = 'Refrigerante'),
 '44444444444', '12345678000190'),
('Entrada', 15, '2026-11-10',
 (SELECT id_produto FROM produto WHERE nome = 'Hamburguer'),
 '44444444444', '98765432000110'),
('Entrada', 10, '2026-11-10',
 (SELECT id_produto FROM produto WHERE nome = 'Pizza'),
 '44444444444', '98765432000110');

-- 1.11 PEDIDOS
INSERT INTO pedido
(data, horario, status, cpf_cliente, cpf_funcionario, numero_mesa)
VALUES
('2026-11-10', '12:00:00', 'Finalizado', '11111111111', '55555555555', 1),
('2026-11-10', '12:30:00', 'Finalizado', '22222222222', '55555555555', 2),
('2026-11-10', '13:00:00', 'Finalizado', '33333333333', '55555555555', 3);

-- 1.12 ITENS DOS PEDIDOS
INSERT INTO item_pedido
(id_produto, id_pedido, quantidade, preco_unitario)
VALUES
(1, 1, 2, 6.00),
(3, 1, 1, 25.00),
(2, 2, 2, 8.00),
(5, 2, 1, 10.00),
(4, 3, 1, 40.00),
(6, 3, 2, 18.00);

-- 1.13 PAGAMENTOS
INSERT INTO pagamento
(valor, data, horario, id_pedido, id_forma_pagamento)
VALUES
(37.00, '2026-11-10', '12:15:00', 1, 2),
(16.00, '2026-11-10', '12:45:00', 2, 1),
(10.00, '2026-11-10', '12:46:00', 2, 3),
(76.00, '2026-11-10', '13:15:00', 3, 4);

-- =====================================================
-- 2. CONSULTAS BASICAS
-- =====================================================

-- Consulta 1: Todos os produtos
SELECT * FROM produto;

-- Consulta 2: Nome e preco dos produtos
SELECT nome, preco_venda
FROM produto;

-- Consulta 3: Produtos com preco superior a R$ 10,00
SELECT nome, preco_venda
FROM produto
WHERE preco_venda > 10;

-- Consulta 4: Produtos ordenados por preco
SELECT nome, preco_venda
FROM produto
ORDER BY preco_venda ASC;

-- Consulta 5: Funcionarios ordenados pelo nome
SELECT nome, telefone
FROM funcionario
ORDER BY nome ASC;

-- Consulta 6: Quantidade total de produtos
SELECT COUNT(*) AS total_produtos
FROM produto;

-- =====================================================
-- 3. CONSULTAS INTERMEDIARIAS
-- =====================================================

-- Consulta 7: Produtos e categorias
SELECT
    p.nome AS produto,
    c.nome AS categoria,
    p.preco_venda
FROM produto p
INNER JOIN categoria c
    ON p.id_categoria = c.id_categoria;

-- Consulta 8: Pedidos, clientes e funcionarios
SELECT
    pe.id_pedido,
    cl.nome AS cliente,
    f.nome AS funcionario,
    pe.data,
    pe.status
FROM pedido pe
INNER JOIN cliente cl
    ON pe.cpf_cliente = cl.cpf
INNER JOIN funcionario f
    ON pe.cpf_funcionario = f.cpf;

-- Consulta 9: Total de cada pedido
SELECT
    ip.id_pedido,
    SUM(ip.quantidade * ip.preco_unitario) AS total_pedido
FROM item_pedido ip
GROUP BY ip.id_pedido;

-- Consulta 10: Quantidade de pedidos por cliente
SELECT
    cl.nome AS cliente,
    COUNT(pe.id_pedido) AS total_pedidos
FROM cliente cl
LEFT JOIN pedido pe
    ON cl.cpf = pe.cpf_cliente
GROUP BY cl.cpf, cl.nome;

-- Consulta 11: Total recebido por forma de pagamento
SELECT
    fp.nome AS forma_pagamento,
    SUM(pg.valor) AS total_recebido
FROM pagamento pg
INNER JOIN forma_pagamento fp
    ON pg.id_forma_pagamento = fp.id_forma_pagamento
GROUP BY fp.id_forma_pagamento, fp.nome;

-- Consulta 12: Media de precos por categoria
SELECT
    c.nome AS categoria,
    AVG(p.preco_venda) AS media_precos
FROM categoria c
INNER JOIN produto p
    ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria, c.nome;

-- =====================================================
-- 4. CONSULTAS AVANCADAS
-- =====================================================

-- Consulta 13: Produtos acima da media de preco
SELECT nome, preco_venda
FROM produto
WHERE preco_venda > (
    SELECT AVG(preco_venda)
    FROM produto
);

-- Consulta 14: Clientes que ja realizaram pedidos
SELECT nome
FROM cliente cl
WHERE EXISTS (
    SELECT 1
    FROM pedido pe
    WHERE pe.cpf_cliente = cl.cpf
);

-- Consulta 15: Categorias com mais de um produto
SELECT
    c.nome AS categoria,
    COUNT(p.id_produto) AS quantidade_produtos
FROM categoria c
INNER JOIN produto p
    ON c.id_categoria = p.id_categoria
GROUP BY c.id_categoria, c.nome
HAVING COUNT(p.id_produto) > 1;

-- Consulta 16: Produto mais caro de cada categoria
SELECT
    c.nome AS categoria,
    p.nome AS produto,
    p.preco_venda
FROM produto p
INNER JOIN categoria c
    ON p.id_categoria = c.id_categoria
WHERE p.preco_venda = (
    SELECT MAX(p2.preco_venda)
    FROM produto p2
    WHERE p2.id_categoria = p.id_categoria
);

-- Consulta 17: Classificacao da situacao do estoque
SELECT
    nome,
    quantidade,
    estoque_minimo,
    CASE
        WHEN quantidade = 0 THEN 'Sem estoque'
        WHEN quantidade <= estoque_minimo THEN 'Estoque baixo'
        ELSE 'Estoque adequado'
    END AS situacao_estoque
FROM produto;

-- Consulta 18: Relatorio financeiro dos pedidos
-- Itens e pagamentos sao somados separadamente para evitar duplicacao dos valores.
SELECT
    pe.id_pedido,
    cl.nome AS cliente,
    COALESCE(it.total_pedido, 0) AS total_pedido,
    COALESCE(pg.total_pago, 0) AS total_pago
FROM pedido pe
LEFT JOIN cliente cl
    ON pe.cpf_cliente = cl.cpf
LEFT JOIN (
    SELECT
        id_pedido,
        SUM(quantidade * preco_unitario) AS total_pedido
    FROM item_pedido
    GROUP BY id_pedido
) it
    ON pe.id_pedido = it.id_pedido
LEFT JOIN (
    SELECT
        id_pedido,
        SUM(valor) AS total_pago
    FROM pagamento
    GROUP BY id_pedido
) pg
    ON pe.id_pedido = pg.id_pedido;
