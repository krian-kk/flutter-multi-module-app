class Agent {
  Agent({this.secondaryAgent, this.agentRef, this.name, this.type});

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        secondaryAgent: json['secondaryAgent'] as String?,
        agentRef: json['agentRef'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
      );
  String? secondaryAgent;
  String? agentRef;
  String? name;
  String? type;

  Map<String, dynamic> toJson() => {
        'secondaryAgent': secondaryAgent,
        'agentRef': agentRef,
        'name': name,
        'type': type,
      };
}
