package com.ozunas.model;

import java.math.BigDecimal;

public class MenuItem {
    private int id;
    private String nome;
    private String descricao;
    private BigDecimal preco;
    private String categoria;
    private String imagemUrl;
    private boolean destaque;

    public MenuItem(int id, String nome, String descricao, BigDecimal preco, String categoria, String imagemUrl, boolean destaque) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
        this.categoria = categoria;
        this.imagemUrl = imagemUrl;
        this.destaque = destaque;
    }

    public int getId() {
        return id;
    }

    public String getNome() {
        return nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public BigDecimal getPreco() {
        return preco;
    }

    public String getCategoria() {
        return categoria;
    }

    public String getImagemUrl() {
        return imagemUrl;
    }

    public boolean isDestaque() {
        return destaque;
    }
}
