import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment{
  static String verdeAPI = dotenv.env['TEAM_VERDE_API'] ?? 'No hay API URL VERDE';
  static String rojoAPI = dotenv.env['TEAM_ROJO_API'] ?? 'No hay API URL ROJO';
  static String naranjaAPI = dotenv.env['TEAM_NARANJA_API'] ?? 'No hay API URL NARANJA';
  static String azulAPI = dotenv.env['TEAM_AZUL_API'] ?? 'No hay API URL AZUL';
  static String amarilloAPI = dotenv.env['TEAM_AMARILLO_API'] ?? 'No hay API URL AMARILLO';
}