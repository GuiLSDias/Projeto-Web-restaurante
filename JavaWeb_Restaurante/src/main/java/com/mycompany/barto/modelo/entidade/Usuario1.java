package com.mycompany.barto.modelo.entidade;

public class Usuario1 {

    private int idUsuario;
    private String usuario;
    private String senha;

    public Usuario1(int idUsuario, String usuario, String senha) {
        this.idUsuario = idUsuario;
        this.usuario = usuario;
        this.senha = senha;
    }

    public Usuario1(String usuario, String senha) {
        this.usuario = usuario;
        this.senha = senha;
    }

    public Usuario1() {
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}
