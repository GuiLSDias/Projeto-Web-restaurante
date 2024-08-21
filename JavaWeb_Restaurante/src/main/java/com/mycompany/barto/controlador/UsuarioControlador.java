/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.barto.controlador;

import com.mycompany.barto.modelo.dao.UsuarioDao;
import com.mycompany.barto.modelo.entidade.Usuario1;
import com.mycompany.barto.servico.WebConstantes;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author 44976560805
 */
@WebServlet(WebConstantes.BASE_PATH + "/CadastroUser")
public class UsuarioControlador extends HttpServlet {
    private UsuarioDao usuarioDao;
    private Usuario1 usuario1;
    private String idUsuario = ""; 
    private String usuario;
    private String senha = "";
    private String opcao = "";

    @Override
    public void init() throws ServletException {
        usuarioDao = new UsuarioDao();
        usuario1 = new Usuario1();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            idUsuario = request.getParameter("idUsuario");
            usuario = request.getParameter("usuario");
            senha = request.getParameter("senha");
            

            if (opcao == null || opcao.isEmpty()) {
                opcao = "cadastrar";
            }

            switch (opcao) {
                case "cadastrar":
                    cadastrar(request, response);
                    break;
                case "editar":
                    editar(request, response);
                    break;
                case "confirmarEditar":
                    confirmarEditar(request, response);
                    break;
                case "excluir":
                    excluir(request, response);
                    break;
                case "confirmarExcluir":
                    confirmarExcluir(request, response);
                    break;
                case "cancelar":
                    cancelar(request, response);
                    break;
                case "encaminharParaPagina":
                    encaminharParaPagina(request, response);
                    break;
                default:
                    throw new IllegalArgumentException("Opção inválida " + opcao);
            }

        } catch (NumberFormatException e) {
            response.getWriter().println("Erro: um ou mais parâmetros não são números válidos");
        } catch (IllegalArgumentException e) {
            response.getWriter().println("Erro: " + e.getMessage());
        }
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        validaCampos();
        usuario1.setUsuario(usuario);
        usuario1.setSenha(senha);
        
        usuarioDao.salvar(usuario1);
        encaminharParaPagina(request, response);
    }

    private void editar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("idUsuario", idUsuario);
        request.setAttribute("opcao", "confirmarEditar");
        request.setAttribute("usuario", usuario);
        request.setAttribute("senha", senha);
        
        request.setAttribute("mensagem", "Edite os dados e clique em salvar");

        encaminharParaPagina(request, response);
    }

    private void excluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("idUsuario", idUsuario);
        request.setAttribute("opcao", "confirmarExcluir");
        request.setAttribute("usuario", usuario);
        request.setAttribute("senha", senha);
        request.setAttribute("mensagem", "Clique em salvar para confirmar a exclusão dos dados");
        encaminharParaPagina(request, response);
    }

    private void confirmarEditar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            validaCampos(); // Valida os campos recebidos

            // Criação e configuração do objeto Caixa
            Usuario1 usuarioEditado = new Usuario1();
            usuarioEditado.setIdUsuario(parseInt(request.getParameter("idUsuario")));
            usuarioEditado.setUsuario(request.getParameter("usuario"));
            usuarioEditado.setSenha(request.getParameter("senha"));
            
            // Atualização da caixa no banco de dados
            usuarioDao.alterar(usuarioEditado);

            // Redireciona para o método cancelar após a atualização
            cancelar(request, response);
        } catch (IllegalArgumentException e) {
            // Trata erros relacionados à validação de campos
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Erro na validação dos campos: " + e.getMessage());
        } catch (Exception e) {
            // Trata outros erros inesperados
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro inesperado: " + e.getMessage());
        }
    }

    // Método auxiliar para conversão de String para int
    private int parseInt(String value) {
        return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : 0;
    }

    private void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        usuario1.setIdUsuario(Integer.parseInt(request.getParameter("idUsuario")));
        usuarioDao.excluir(usuario1);
        cancelar(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("idUsuario", idUsuario);
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("usuario", usuario);
        request.setAttribute("senha", senha);
        encaminharParaPagina(request, response);
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuario1> usuarios = usuarioDao.buscarTodos();
        request.setAttribute("usuario", usuarios);
        request.setAttribute(opcao, opcao);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroUsuario.jsp");
        dispatcher.forward(request, response);
    }

    public void validaCampos() {
        if (usuario == null || usuario.isEmpty() || senha == null || senha.isEmpty()) {
            throw new IllegalArgumentException("Um ou mais parâmetros estão ausentes");
        }
    }
}


