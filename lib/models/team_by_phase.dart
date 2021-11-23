class TeamByPhase {
  final int projectId;
  final List<dynamic> projectData;
  final String leader;
  final String teamName;
  final int phaseActual;

  TeamByPhase({
    required this.projectId,
    required this.teamName,
    required this.leader,
    required this.phaseActual,
    required this.projectData,
  });
}
