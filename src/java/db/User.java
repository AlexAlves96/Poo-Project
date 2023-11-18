/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Alex
 */
// User.java
package db;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.time.*;
import java.util.ArrayList;
import web.DatabaseListener;


public class User {

    private Integer userid;
    private String nome;
    private String sobrenome;
    private String usuario;
    private String senha;

    public static void addUser(String nome, String sobrenome, String apelido, String senha) throws Exception {
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("INSERT INTO users (nome, sobrenome, apelido, senha)"
                + "VALUES (?,?,?,?)");
        stmt.setString(1, nome);
        stmt.setString(2, sobrenome);
        stmt.setString(3, apelido);
        stmt.setString(4, senha);
        stmt.execute();
        stmt.close();
        con.close();
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public void setSobrenome(String sobrenome) {
        this.sobrenome = sobrenome;
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
    
    
      public static boolean authenticateUser(String username, String password) throws Exception {
        Connection con = DatabaseListener.getConnection();
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM users WHERE apelido = ? AND senha = ?");
        stmt.setString(1, username);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        boolean userFound = rs.next();

        rs.close();
        stmt.close();
        con.close();

        return userFound;
    }
}
