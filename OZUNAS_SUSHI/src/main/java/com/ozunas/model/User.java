package com.ozunas.model;

public class User {
    private int id;
    private String nome;
    private String email;
    private String perfil;

    public User(int id, String nome, String email, String perfil) {
        this.id = id;
        this.nome = nome;
        this.email = email;
        this.perfil = perfil;
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getEmail() {
        return email;
    }

    public String getPerfil() {
        return perfil;
    }

    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(perfil);
    }
}
