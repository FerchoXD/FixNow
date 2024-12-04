import 'dart:convert';
import 'package:fixnow/domain/entities/message.dart';
import 'package:fixnow/infrastructure/services/data_history_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fixnow/infrastructure/services/data_history_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AsistantState {
  final List<Message> messageList;
  final bool isConnected;
  final bool isLoadingChat;
  final bool isWritingBot;

  AsistantState({
    this.messageList = const [],
    this.isConnected = false,
    this.isLoadingChat = true,
    this.isWritingBot = false,
  });

  AsistantState copyWith({
    List<Message>? messageList,
    bool? isConnected,
    bool? isLoadingChat,
    bool? isWritingBot,
  }) =>
      AsistantState(
        messageList: messageList ?? this.messageList,
        isConnected: isConnected ?? this.isConnected,
        isLoadingChat: isLoadingChat ?? this.isLoadingChat,
        isWritingBot: isWritingBot ?? this.isWritingBot,
      );
}

class AsistantNotifier extends StateNotifier<AsistantState> {
  final ScrollController chatScrollController = ScrollController();
  late GenerativeModel chatModel;
  final List<Content> history = [];

  final DataHistoryService dataHistoryService = DataHistoryService();

  AsistantNotifier() : super(AsistantState()) {
    configureChatModel();
    // _startListeningToConnectivity();
    loadConversation();
  }

  void configureChatModel() {
    chatModel = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: "AIzaSyDHjbUqF2thTON9DUgwa_6ocvBQgq4aL2A",
    );
  }

  // void _startListeningToConnectivity() {
  //   Connectivity().onConnectivityChanged.listen((connectivityResult) {
  //     updateConnectionStatus(connectivityResult);
  //   });
  // }

  // void updateConnectionStatus(ConnectivityResult result) {
  //   bool connected = result != ConnectivityResult.none;
  //   state = state.copyWith(isConnected: connected);
  // }

  Future<void> geminiMessage(text) async {
    final newMessageGemini = Message(text: text, fromWho: FromWho.gemini);
    state =
        state.copyWith(messageList: [...state.messageList, newMessageGemini]);
    moveScrollToBottom();
    await dataHistoryService.saveConversation(state.messageList);
  }

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    final newMessage = Message(text: text, fromWho: FromWho.me);
    state = state.copyWith(
      messageList: [...state.messageList, newMessage],
    );
    moveScrollToBottom();

    // Valida si la pregunta es relevante antes de obtener una respuesta.
    if (!esRelacionadoAlContexto(text)) {
      final mensajeError =  "Por favor, realiza preguntas relacionadas con servicios de mantenimiento y reparaciones del hogar.";
      state = state.copyWith(
        messageList: [
          ...state.messageList,
          Message(text: mensajeError, fromWho: FromWho.gemini)
        ],
      );
      return;
    }

    history.add(Content.text(text));
    geminiResponse(text);
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  Future<void> loadConversation() async {
    final listMessages = await dataHistoryService.loadConversation();
    if (listMessages != null) {
      List<Message> restoredMessages = listMessages.map((msgStr) {
        var msg = jsonDecode(msgStr);
        return Message(
          text: msg['text'],
          fromWho: msg['fromWho'] == 'me' ? FromWho.me : FromWho.gemini,
        );
      }).toList();
      state = state.copyWith(messageList: restoredMessages);
    }
    for (var message in state.messageList) {
      if (message.fromWho == FromWho.me) {
        history.add(Content.text(message.text));
      } else {
        history.add(Content.model([TextPart(message.text)]));
      }
    }

    state = state.copyWith(isLoadingChat: false);
    moveScrollToBottom();
  }

  Future<void> geminiResponse(String text) async {
    state = state.copyWith(isWritingBot: true);

    const String contexto =
        "Responde solo preguntas relacionadas con servicios de mantenimiento y reparaciones del hogar.";
    final chat =
        chatModel.startChat(history: [Content.text(contexto), ...history]);

    var response = await chat.sendMessage(Content.text(text));
    history.add(Content.model([TextPart(response.text!)]));

    // Usa una variable para manejar el texto de la respuesta
    String responseText = response.text!;

    if (!esRelacionadoAlContexto(responseText)) {
      responseText =
          "Lo siento, solo puedo responder preguntas sobre servicios de mantenimiento y reparaciones del hogar.";
    }

    await geminiMessage(responseText);
    state = state.copyWith(isWritingBot: false);
  }

// Función para filtrar respuestas irrelevantes (puedes personalizarla).
  bool esRelacionadoAlContexto(String respuesta) {
    final palabrasClave = [
      'reparación',
      'mantenimiento',
      'hogar',
      'servicio',
      'técnico',
      'plomería',
      'electricidad',
      'fontanería',
      'cerrajería',
      'limpieza',
      'albañilería',
      'pintura',
      'jardinería',
      'calefacción',
      'aire acondicionado',
      'climatización',
      'electrodomésticos',
      'instalación',
      'desinfección',
      'fugas',
      'gotera',
      'cerradura',
      'tuberías',
      'ventanas',
      'puertas',
      'techos',
      'paredes',
      'renovación',
      'remodelación',
      'presupuesto',
      'cotización',
      'asesoría',
      'urgencia',
      'emergencia',
      'contratar',
      'proyecto',
      'muebles',
      'impermeabilización',
      'balcones',
      'terrazas',
      'pérgolas',
      'piscinas',
      'calderas',
      'sistemas de seguridad',
      'alarma',
      'domótica',
      'iluminación',
      'interruptores',
      'enchufes',
      'ventiladores',
      'calentadores',
      'grifos',
      'cisterna',
      'tanque',
      'desagüe',
      'cocina',
      'baño',
      'azulejos',
      'pisos',
      'paredes',
      'techumbres',
      'pérdidas',
      'cortinas',
      'persianas',
      'soporte',
      'pared',
      'pintar',
      'redecorar',
      'decoración',
      'espejos',
      'colgar',
      'tornillos',
      'clavos',
      'herramientas',
      'drenaje',
      'saneamiento',
      'plagas',
      'fumigación',
      'insectos',
      'termitas',
      'ratas',
      'control',
      'poda',
      'césped',
      'cercos',
      'cercado',
      'árboles',
      'madera',
      'barniz',
      'sellador',
      'vidrio',
      'cristal',
      'rotura',
      'filtraciones',
      'humedad',
      'limpieza profunda',
      'desincrustante',
      'piedra',
      'rejillas',
      'barandales',
      'escaleras',
      'ascensores',
      'elevadores',
      'goteras',
      'chapas',
      'llaves',
      'bisagras',
      'marcos',
      'cerraduras electrónicas',
      'código',
      'control remoto',
      'cámaras',
      'videovigilancia',
      'alarma contra incendios',
      'extintores',
      'bomberos',
      'protección',
      'seguridad',
      'aislamiento',
      'sonido',
      'calor',
      'frío',
      'ventilación',
      'extractor',
      'conductos',
      'ductos',
      'pared falsa',
      'tablaroca',
      'yeso',
      'acabados',
      'ornamentación',
      'pisos laminados',
      'mármol',
      'granito',
      'cemento',
      'aditivos',
      'pegamentos',
      'selladores',
      'impermeabilizante',
      'revestimientos',
      'techado',
      'baldosas',
      'cerámica',
      'porcelanato',
      'ducha',
      'llaves de agua',
      'calentador solar',
      'gas',
      'electricista',
      'plomero',
      'albañil',
      'pintor',
      'jardinero',
      'techo',
      'plafón',
      'correcciones',
      'ajustes',
      'reemplazos',
      'compost',
      'huertos',
      'riego',
      'aspersores',
      'reparación de muebles',
      'ensamble',
      'puertas corredizas',
      'ventanas abatibles',
      'paneles solares',
      'energía',
      'baterías',
      'conexiones',
      'cableado',
      'tuberías de gas',
      'instalación eléctrica',
      'transformadores',
      'inversores',
      'sistemas eléctricos',
      'motor',
      'generadores',
      'limpieza de canaletas',
      'desagües obstruidos',
      'limpieza de ductos',
      'filtro de agua',
      'purificador',
      'electrónica',
      'domicilio',
      'asistencia técnica',
      'empaques',
      'ajustes de puertas',
      'barniz de madera',
      'desarmar',
      'montaje',
      'pladur',
      'encofrado',
      'cimentación',
      'muros',
      'fachadas',
      'colocación',
      'cortafuegos',
      'foco',
      'reparar',
      'mantener',
      'encender',
      'reparaciones',
      'agua',
      'luz',
      'gas',
      'electricidad',
      'fontanería',
      'plomería',
      'albañilería',
      'jardinería',
      'limpieza',
      'pintura',
      'ventanas',
      'puertas',
      'calefacción',
      'aire acondicionado',
      'techo',
      'techado',
      'impermeabilización',
      'madera',
      'cerámica',
      'grifería',
      'tuberías',
      'desagües',
      'baños',
      'cocinas',
      'suelos',
      'azulejos',
      'herramientas',
      'remodelación',
      'mantenimiento',
      'renovación',
      'inspección',
      'calderas',
      'cisternas',
      'servicios',
      'hogar',
      'instalación',
      'revisión',
      'energía',
      'seguridad',
      'ventilación',
      'drenaje',
      'iluminación',
      'electrodomésticos',
      'techumbre',
      'mobiliario',
      'saneamiento',
      'desinfección',
      'pérgolas',
      'clósets',
      'rejas',
      'sistemas',
      'estructuras',
      'piscinas',
      'bombas',
      'calentadores',
      'paneles solares',
      'canaletas',
      'chimeneas',
      'aislamiento',
      'vidrios',
      'herrería',
      'domótica',
      'automatización',
      'carpintería',
      'zanjado',
      'excavación',
      'bases',
      'cimientos',
      'paredes',
      'muros',
      'acondicionamiento',
      'pavimentación',
      'cubiertas',
      'techados',
      'sellado',
      'resanado',
      'limpieza profunda',
      'encimeras',
      'interiores',
      'exteriores',
      'fachadas',
      'ventanales',
      'vidrios templados',
      'laminado',
      'vinílico',
      'decoración',
      'ornamentación',
      'cortinas',
      'persianas',
      'electrónica',
      'circuitos',
      'iluminación LED',
      'extractores',
      'extractores de aire',
      'fregaderos',
      'interruptores',
      'enchufes',
      'tomacorrientes',
      'fusibles',
      'disyuntores',
      'transformadores',
      'serruchos',
      'taladros',
      'destornilladores',
      'llaves',
      'sargentos',
      'martillos',
      'maquinarias',
      'compresores',
      'neumáticos',
      'torres',
      'andamios',
      'escaleras',
      'cubiertas de seguridad',
      'guardas',
      'resistencias',
      'termómetros',
      'detalles',
      'personalización',
      'acabados',
      'brillado',
      'barnizado',
      'pulido',
      'pintado',
      'recubrimiento',
      'enchapado',
      'inclusión',
      'resistencias eléctricas',
      'transformadores eléctricos',
      'tomacorrientes',
      'paredes internas',
      'paredes externas',
      'estructuración',
      'reconstrucción',
      'muros internos',
      'muros externos',
      'limpieza de vidrios',
      'mantenimiento de techos',
      'cambio de cerraduras',
      'cerraduras electrónicas',
      'mantenimiento de muebles',
      'instalación de persianas',
      'mantenimiento de pisos',
      'restauración',
      'reparación de cortinas',
      'restauración de muebles',
      'piso flotante',
      'recambio de cerámicas',
      'reparación de grifería',
      'inspección de fugas',
      'tratamiento de agua',
      'control de plagas',
      'fumigación',
      'calibración de electrodomésticos',
      'ajuste de persianas',
      'mantenimiento de jardines',
      'riego automatizado',
      'poda de árboles',
      'iluminación exterior',
      'corte de césped',
      'mantenimiento de piscinas',
      'control de temperatura',
      'ventanas correderas',
      'cambio de vidrios',
      'revisión de paneles',
      'mantenimiento preventivo',
      'detección de humedad',
      'deshumidificación',
      'reforzamiento de paredes',
      'pintura de exteriores',
      'pintura de interiores',
      'lavado de paredes',
      'lavado de techos',
      'ajuste de tuberías',
      'reparación de fugas',
      'instalación de filtros',
      'instalación de calentadores',
      'sistemas de riego',
      'sistemas de drenaje',
      'automatización del hogar',
      'control remoto',
      'monitoreo remoto',
      'sistemas de videovigilancia',
      'cerraduras inteligentes',
      'sensores de movimiento',
      'alarma de incendios',
      'extintores',
      'red eléctrica',
      'reparación de calderas',
      'revisión de sistemas',
      'instalación de alarmas',
      'instalación de cámaras',
      'revisión de paneles solares',
      'sustitución de componentes',
      'soporte técnico',
      'gestión de reparaciones',
      'soporte de hogar',
      'reemplazo de piezas',
      'detalles de hogar',
      'optimización de espacios',
      'ampliación',
      'proyectos a medida',
      'técnicos calificados',
      'asistencia inmediata',
      'soluciones integrales'
    ];

    return palabrasClave.any((palabra) => respuesta.contains(palabra));
  }

  Future<void> newConversation() async {
    state = state.copyWith(messageList: [], isLoadingChat: true);
    history.clear();
    history.add(Content.text(
        "Eres un asistente que responde exclusivamente sobre servicios de mantenimiento y reparaciones del hogar."));
    await dataHistoryService.clearConversation();
    state = state.copyWith(isLoadingChat: false);
  }
}

final assistantProvider = StateNotifierProvider<AsistantNotifier, AsistantState>((ref) {
  return AsistantNotifier();
});
