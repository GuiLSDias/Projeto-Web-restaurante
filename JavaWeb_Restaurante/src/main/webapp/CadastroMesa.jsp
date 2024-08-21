<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="areaRestrita.jsp" %>

<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Mesa</title>
    <style>
        /* Estilos básicos para o corpo da página */
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
    <script>
        function submitForm(opcaoValue) {
            document.getElementById("opcao").value = opcaoValue;
            document.getElementById("cadastroForm").submit();
        }
    </script>
</head>
<body>
    <h1>Cadastro de Mesa</h1>
    <div class="container">
        <form id="cadastroForm" name="cadastroForm" action="${pageContext.request.contextPath}${URL_BASE}/MesaControlador" method="get">
            <input type="hidden" name="opcao" value="${opcao}" id="opcao" />
            <input type="hidden" name="id_mesa" value="${id_mesa}" />

            <p>
                <label for="numero"><strong>Número da Mesa:</strong></label>
                <input type="text" id="numero" name="numero" value="${numero}" required />
            </p>

            <p>
                <label for="capacidade"><strong>Capacidade:</strong></label>
                <input type="text" id="capacidade" name="capacidade" value="${capacidade}" required />
            </p>

            <input type="submit" value="Salvar" />
        </form>

        <form name="cancelarForm" action="${pageContext.request.contextPath}${URL_BASE}/MesaControlador" method="get">
            <input type="hidden" name="opcao" value="cancelar" />
            <input type="submit" value="Cancelar" />
        </form>

        <c:if test="${not empty mensagem}">
            <p class="message">${mensagem}</p>
        </c:if>

        <h2>Lista de Mesas</h2>
        <table>
            <c:if test="${not empty mesas}">
                <tr>
                    <th>Número</th>
                    <th>Capacidade</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </c:if>

            <c:forEach var="mesa" items="${mesas}">
                <tr>
                    <td>${mesa.numero}</td>
                    <td>${mesa.capacidade}</td>
                    <td>
                        <form name="editarForm" action="${pageContext.request.contextPath}${URL_BASE}/MesaControlador" method="get">
                            <input type="hidden" name="id_mesa" value="${mesa.id_mesa}" />
                            <input type="hidden" name="numero" value="${mesa.numero}" />
                            <input type="hidden" name="capacidade" value="${mesa.capacidade}" />
                            <input type="hidden" name="opcao" value="editar" />
                            <button type="submit">Editar</button>
                        </form>
                    </td>
                    <td>
                        <form name="excluirForm" action="${pageContext.request.contextPath}${URL_BASE}/MesaControlador" method="get">
                            <input type="hidden" name="id_mesa" value="${mesa.id_mesa}" />
                            <input type="hidden" name="numero" value="${mesa.numero}" />
                            <input type="hidden" name="capacidade" value="${mesa.capacidade}" />
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
