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

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import web.DatabaseListener;

public class User {

    private Integer userid;
    private String nome;
    private String sobrenome;
    private String usuario;
    private String password;

    public static void addUser(String nome, String sobrenome, String username, String password) throws SQLException, Exception {
        try (Connection con = DatabaseListener.getConnection();
             PreparedStatement stmt = con.prepareStatement("INSERT INTO users (nome, sobrenome, username, password) VALUES (?, ?, ?, ?)")) {

            stmt.setString(1, nome);
            stmt.setString(2, sobrenome);
            stmt.setString(3, username);
            stmt.setString(4, password);
            stmt.executeUpdate();
        }
    }

    public static boolean authenticateUser(String nome, String password) throws SQLException, Exception {
        try (Connection con = DatabaseListener.getConnection();
             PreparedStatement stmt = con.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?")) {

            stmt.setString(1, nome);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
    
    public static boolean isUsernameUnique(String nome) throws SQLException, Exception {
        try (Connection con = DatabaseListener.getConnection();
             PreparedStatement stmt = con.prepareStatement("SELECT COUNT(*) FROM users WHERE username = ?")) {

            stmt.setString(1, nome);

            try (ResultSet resultSet = stmt.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count == 0; // Return true if count is 0 (nome is unique)
                }
            }
        }

        return false; // Return false by default (considering an error occurred)
    }


    // Getters and setters

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
        return password;
    }

    public void setSenha(String password) {
        this.password = password;
    }
}
