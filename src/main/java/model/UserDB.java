package model;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.concurrent.ConcurrentHashMap;

public class UserDB implements Serializable {
    private static final long serialVersionUID = 1L;
    private static final String FILE_PATH = "users.ser";
    private static UserDB instance;
    private ConcurrentHashMap<String, UserBean> users;

    private UserDB() {
        users = loadUsers();
    }

    public static synchronized UserDB getInstance() {
        if (instance == null) {
            instance = new UserDB();
        }
        return instance;
    }

    public synchronized void addUser(UserBean user) {
        users.put(user.getEmail(), user);
        saveUsers();
    }

    public synchronized UserBean getUser(String email) {
        return users.get(email);
    }

    public synchronized void updateUser(UserBean user) {
        users.put(user.getEmail(), user);
        saveUsers();
    }

    public synchronized boolean containsEmail(String email) {
        return users.containsKey(email);
    
    }

    @SuppressWarnings("unchecked")
    private ConcurrentHashMap<String, UserBean> loadUsers() {
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_PATH))) {
            return (ConcurrentHashMap<String, UserBean>) ois.readObject();
        } catch (IOException | ClassNotFoundException e) {
            return new ConcurrentHashMap<>();
        }
    }

    private void saveUsers() {
        System.err.println("Saving DB to: " + new File(FILE_PATH).getAbsolutePath());
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
            oos.writeObject(users);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}