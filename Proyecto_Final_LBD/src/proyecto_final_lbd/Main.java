package proyecto_final_lbd;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.JOptionPane;

public class Main {
    public static void main(String[] args) {
        String tab_Aeropuertos = "SELECT * FROM Aeropuertos";
        String tab_Aerolineas = "SELECT * FROM Aerolineas";
        String tab_Vuelos = "SELECT * FROM Vuelos";
        String tab_Comida_a_Bordo = "SELECT * FROM Comida_a_Bordo";
        String tab_Horarios = "SELECT * FROM Horarios";
        String tab_Precios = "SELECT * FROM Precios";
        String tab_Pasajeros = "SELECT * FROM Pasajeros";
        String tab_Reservas = "SELECT * FROM Reservas";
        String tab_Equipaje = "SELECT * FROM Equipaje";
        String tab_Comentarios_y_Reservas = "SELECT * FROM Comentarios_y_Reservas";
        ConexionOracle co = new ConexionOracle();
        
        byte num = Byte.parseByte(JOptionPane.showInputDialog("*-- MENU PRINCIPAL --*\n\n"
                + "1.Tabla de Aeropuertos\n"
                + "2.Tabla de Aerolineas\n"
                + "3.Tabla de Vuelos\n"
                + "4.Tabla de Comida a bordo\n"
                + "5.Tabla de Horarios\n"
                + "6.Tabla de Precios\n"
                + "7.Tabla de Pasajeros\n"
                + "8.Tabla de Reservas\n"
                + "9.Tabla de Equipaje\n"
                + "10.Tabla de Comentarios y Reservas\n"
                + "11.Salir\n"
                + "Digite el numero de la tabla que desea: "));

        switch (num) {
            case 1:
                    try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Aeropuertos);
            
                        System.out.println("               ** AEROPUERTOS **\n");
                        while (rs.next()) {      
                            int ID_Aeropuerto = rs.getInt("ID_Aeropuerto");
                            String Nombre = rs.getString("Nombre");
                            String Ciudad = rs.getString("Ciudad");
                            String Pais = rs.getString("Pais");
                            String Codigo_IATA = rs.getString("Codigo_IATA");
                            String Codigo_ICAO = rs.getString("Codigo_ICAO");
                
                            System.out.println("ID_Aeropuerto: " + ID_Aeropuerto + "\nNombre: " + Nombre + "\nCiudad: " + Ciudad 
                                    + "\nPais: " + Pais + "\nCodigo_IATA: " + Codigo_IATA + "\nCodigo_ICAO " + Codigo_ICAO + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                    break;
                    case 2:
                    try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Aerolineas);
            
                        System.out.println("               ** AEROLINEAS **\n");
                        while (rs.next()) {      
                            int ID_Aerolinea = rs.getInt("ID_Aerolinea");
                            String Nombre = rs.getString("Nombre");
                            String Pais = rs.getString("Pais");
                            String ID_Aeropuerto = rs.getString("ID_Aeropuerto");
                
                            System.out.println("ID_Aerolinea: " + ID_Aerolinea + "\nNombre: " + Nombre 
                                    + "\nPais: " + Pais + "\nID_Aeropuerto: " + ID_Aeropuerto + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }    
                        break;
                    case 3:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Vuelos);
            
                        System.out.println("               ** VUELOS **\n");
                        while (rs.next()) {      
                            int ID_Vuelo = rs.getInt("ID_Vuelo");
                            String Origen = rs.getString("Origen");
                            String Destino = rs.getString("Destino");
                            String Fecha_Salida = rs.getString("Fecha_Salida");
                            String Fecha_Llegada = rs.getString("Fecha_Llegada");
                            String Estado = rs.getString("Estado");
                            String ID_Aerolinea = rs.getString("ID_Aerolinea");
                
                            System.out.println("ID_Vuelo: " + ID_Vuelo + "\nOrigen: " + Origen 
                                    + "\nDestino: " + Destino + "\nFecha_Salida: " + Fecha_Salida
                            + "\nFecha_Llegada: " + Fecha_Llegada + "\nEstado: " + Estado + "\nID_Aerolinea: " + ID_Aerolinea + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;
                    case 4:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Comida_a_Bordo);
            
                        System.out.println("               ** COMIDA A BORDO **\n");
                        while (rs.next()) {      
                            int ID_Comida = rs.getInt("ID_Comida");
                            String Tipo_de_Comida = rs.getString("Tipo_de_Comida");
                            String Disponibilidad = rs.getString("Disponibilidad");
                            String Precio = rs.getString("Precio");
                            String ID_Vuelo = rs.getString("ID_Vuelo");
                
                            System.out.println("ID_Comida: " + ID_Comida + "\nTipo_de_Comida: " + Tipo_de_Comida 
                                    + "\nDisponibilidad: " + Disponibilidad + "\nPrecio: " + Precio
                            + "\nID_Vuelo: " + ID_Vuelo + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;
                    case 5:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Horarios);
            
                        System.out.println("               ** HORARIOS **\n");
                        while (rs.next()) {      
                            int ID_Horario = rs.getInt("ID_Horario");
                            String Dia_Semana = rs.getString("Dia_Semana");
                            String Hora_Salida = rs.getString("Hora_Salida");
                            String Hora_Llegada = rs.getString("Hora_Llegada");
                            String ID_Vuelo = rs.getString("ID_Vuelo");
                
                            System.out.println("ID_Horario: " + ID_Horario + "\nDia_Semana: " + Dia_Semana 
                                    + "\nHora_Salida: " + Hora_Salida + "\nHora_Llegada: " + Hora_Llegada
                            + "\nID_Vuelo: " + ID_Vuelo + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;
                    case 6:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Precios);
            
                        System.out.println("               ** PRECIOS **\n");
                        while (rs.next()) {      
                            int ID_Precio = rs.getInt("ID_Precio");
                            String Clase = rs.getString("Clase");
                            String Costo = rs.getString("Costo");
                            String ID_Vuelo = rs.getString("ID_Vuelo");
                
                            System.out.println("ID_Precio: " + ID_Precio + "\nClase: " + Clase 
                                    + "\nCosto: " + Costo
                            + "\nID_Vuelo: " + ID_Vuelo + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;
                    case 7:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Pasajeros);
            
                        System.out.println("               ** PASAJEROS **\n");
                        while (rs.next()) {      
                            int ID_Pasajero = rs.getInt("ID_Pasajero");
                            String Nombre = rs.getString("Nombre");
                            String Apellido = rs.getString("Apellido");
                            String Fecha_Nacimiento = rs.getString("Fecha_Nacimiento");
                            String Genero = rs.getString("Genero");
                            String Nacionalidad = rs.getString("Nacionalidad");
                
                            System.out.println("ID_Pasajero: " + ID_Pasajero + "\nNombre: " + Nombre 
                                    + "\nApellido: " + Apellido + "\nFecha_Nacimiento: " + Fecha_Nacimiento 
                            + "\nGenero: " + Genero + "\nNacionalidad: " + Nacionalidad + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;
                    case 8:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Reservas);
            
                        System.out.println("               ** RESERVAS **\n");
                        while (rs.next()) {      
                            int ID_Reserva = rs.getInt("ID_Reserva");
                            String Num_Asiento = rs.getString("Num_Asiento");
                            String Fecha_Reserva = rs.getString("Fecha_Reserva");
                            String ID_Pasajero = rs.getString("ID_Pasajero");
                            String ID_Vuelo = rs.getString("ID_Vuelo");
                
                            System.out.println("ID_Reserva: " + ID_Reserva + "\nNum_Asiento: " + Num_Asiento 
                                    + "\nFecha_Reserva: " + Fecha_Reserva + "\nID_Pasajero: " + ID_Pasajero 
                            + "\nID_Vuelo: " + ID_Vuelo + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;
                    case 9:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Equipaje);
            
                        System.out.println("               ** EQUIPAJE **\n");
                        while (rs.next()) {      
                            int ID_Equipaje = rs.getInt("ID_Equipaje");
                            String Peso = rs.getString("Peso");
                            String Color = rs.getString("Color");
                            String ID_Pasajero = rs.getString("ID_Pasajero");
                
                            System.out.println("ID_Equipaje: " + ID_Equipaje + "\nPeso: " + Peso 
                                    + "\nColor: " + Color + "\nID_Pasajero: " + ID_Pasajero 
                            + "\n");
                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;  
                    case 10:
                        try {
                        Connection con = co.conectar();
                        Statement stat = con.createStatement();
                        ResultSet rs = stat.executeQuery(tab_Comentarios_y_Reservas);
            
                        System.out.println("               ** COMENTARIOS Y RESERVAS **\n");
                        while (rs.next()) {      
                            int ID_Comentarios_y_Reservas = rs.getInt("ID_Comentarios_y_Reservas");
                            String Puntuacion = rs.getString("Puntuacion");
                            String Comentario = rs.getString("Comentario");
                            String ID_Vuelo = rs.getString("ID_Vuelo");
                            String ID_Pasajero = rs.getString("ID_Pasajero");
                
                            System.out.println("ID_Comentarios_y_Reservas: " + ID_Comentarios_y_Reservas + "\nPuntuacion: " + Puntuacion 
                                    + "\nComentario: " + Comentario + "\nID_Vuelo: " + ID_Vuelo + "\nID_Pasajero: " + ID_Pasajero 
                            + "\n"); 

                        }
            
                        rs.close();
                        stat.close();
                        co.desconectar();
            
                    } catch (SQLException e) {
                        System.out.println("Error al ejecutar la consulta: " + e.getMessage());
                    }
                        break;
                    case 11:
                        System.exit(0);
                        break;    
                    default:
                        JOptionPane.showMessageDialog(null,"Opcion incorrecta, intentelo de nuevo");
                        
        }     
    }
}

