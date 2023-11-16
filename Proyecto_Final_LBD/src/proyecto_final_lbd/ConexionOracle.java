package proyecto_final_lbd;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class ConexionOracle {
    private final String DRIVER = "oracle.jdbc.driver.OracleDriver";
    private final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private final String USER = "HR";
    private final String PASSWORD = "12345";

    private Connection conexion;

    public ConexionOracle() {
        this.conexion = null;
    }

    public Connection conectar() throws SQLException {
        try {
            Class.forName(DRIVER);
            conexion = DriverManager.getConnection(URL, USER, PASSWORD);
            return conexion;
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Error al conectar: " + e.getMessage());
        }
    }

    public void desconectar() {
        try {
            if (conexion != null && !conexion.isClosed()) {
                conexion.close();
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}
