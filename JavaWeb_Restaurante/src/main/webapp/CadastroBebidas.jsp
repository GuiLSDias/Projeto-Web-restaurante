<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="areaRestrita.jsp" %>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Bebidas</title>
    <style>
       body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #333;
            color: #fff;
        }

        h1 {
            text-align: center;
            color: #fff;
            margin-top: 20px;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: #444;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.5);
        }

        form {
            margin-bottom: 20px;
        }

        p {
            margin: 10px 0;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #fff;
        }

        input[type="text"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #666;
            border-radius: 4px;
            box-sizing: border-box;
            background-color: #555;
            color: #fff;
        }

        input[type="submit"], button {
            background-color: #000;
            color: #fff;
            border: 1px solid #666;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        input[type="submit"]:hover, button:hover {
            background-color: #222;
        }

        .message {
            color: #ff4d4d;
            text-align: center;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            color: #fff;
        }

        table, th, td {
            border: 1px solid #666;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #555;
        }

        button {
            background-color: #f44336;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin: 2px;
        }

        button:hover {
            background-color: #c62828;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Cadastro de Bebidas</h1>
        <div>
            <form id="cadastroForm" name="cadastroForm" action="${pageContext.request.contextPath}${URL_BASE}/BebidasControlador" method="get">
                <input type="hidden" name="opcao" value="${opcao}" id="opcao" />
                <input type="hidden" name="id_bebida" value="${id_bebida}" />

                <p>
                    <label for="nome"><strong>Nome:</strong></label>
                    <input type="text" id="nome" name="nome" value="${nome}" required />
                </p>

                <p>
                    <label for="preco"><strong>Preço:</strong></label>
                    <input type="text" id="preco" name="preco" value="${preco}" required />
                </p>

                <p>
                    <label for="tipo"><strong>Tipo:</strong></label>
                    <input type="text" id="tipo" name="tipo" value="${tipo}" required />
                </p>

                <input type="submit" name="Salvar" value="Salvar" />
            </form>

            <form name="cancelarForm" action="${pageContext.request.contextPath}${URL_BASE}/BebidasControlador" method="get">
                <input type="hidden" name="opcao" value="cancelar" />
                <input type="submit" name="Cancelar" value="Cancelar" />
            </form>
        </div>
        <div class="message">${mensagem}</div>

        <h2>Lista de Bebidas</h2>

        <table>
            <c:if test="${not empty bebidas}">
                <tr>
                    <th>Nome</th>
                    <th>Preço</th>
                    <th>Tipo</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </c:if>

            <c:forEach var="bebida" items="${bebidas}">
                <tr>
                    <td>${bebida.nome}</td>
                    <td>${bebida.preco}</td>
                    <td>${bebida.tipo}</td>
                    <td>
                        <form name="editarForm" action="${pageContext.request.contextPath}${URL_BASE}/BebidasControlador" method="get">
                            <input type="hidden" name="id_bebida" value="${bebida.id_bebida}" />
                            <input type="hidden" name="nome" value="${bebida.nome}" />
                            <input type="hidden" name="preco" value="${bebida.preco}" />
                            <input type="hidden" name="tipo" value="${bebida.tipo}" />
                            <input type="hidden" name="opcao" value="editar" />
                            <button type="submit">Editar</button>
                        </form>
                    </td>
                    <td>
                        <form name="excluirForm" action="${pageContext.request.contextPath}${URL_BASE}/BebidasControlador" method="get">
                            <input type="hidden" name="id_bebida" value="${bebida.id_bebida}" />
                            <input type="hidden" name="nome" value="${bebida.nome}" />
                            <input type="hidden" name="preco" value="${bebida.preco}" />
                            <input type="hidden" name="tipo" value="${bebida.tipo}" />
                            <input type="hidden" name="opcao" value="excluir" />
                            <button type="submit">Excluir</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>