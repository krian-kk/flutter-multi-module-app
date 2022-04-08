class Agent {
  String? secondaryAgent;
  String? agentRef;
  String? name;
  String? type;

  Agent({this.secondaryAgent, this.agentRef, this.name, this.type});

  factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        secondaryAgent: json['secondaryAgent'] as String?,
        agentRef: json['agentRef'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'secondaryAgent': secondaryAgent,
        'agentRef': agentRef,
        'name': name,
        'type': type,
      };
}
