import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'app_base.dart';

class ServicoLicencaBugs {
  static void inicializarCapturaDeErrosGlobal() {}
  static void abrirModalReportarBug(BuildContext context, UsuarioApp usuario) {}
  static void abrirModalCadastroEmpresaComChave(BuildContext context) {}

  static Stream<List<Map<String, dynamic>>> streamTabelaSegura(
    String tabela, {
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) async* {
    String ultimoJson = '';
    while (true) {
      try {
        dynamic query = supabase.from(tabela).select();
        if (orderBy != null) query = query.order(orderBy, ascending: ascending);
        if (limit != null) query = query.limit(limit);
        final res = await query.timeout(const Duration(seconds: 6));
        final lista = List<Map<String, dynamic>>.from(res as List);
        final novoJson = jsonEncode(lista);
        if (novoJson != ultimoJson) {
          ultimoJson = novoJson;
          yield lista;
        }
      } catch (_) {}
      await Future.delayed(const Duration(seconds: 8));
    }
  }
}

class MonitorLicencaMasterWidget extends StatelessWidget {
  final UsuarioApp usuarioLogado;
  const MonitorLicencaMasterWidget({super.key, required this.usuarioLogado});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}