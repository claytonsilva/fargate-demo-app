{
	"containerDefinitions": [{
		"logConfiguration": {
			"logDriver": "awslogs",
			"options": {
				"awslogs-group": "/ecs/{{TASK}}",
				"awslogs-region": "{{REGION}}",
				"awslogs-stream-prefix": "ecs"
			}
		},
		"portMappings": [{
			"hostPort": {{CONTAINERPORT}},
			"protocol": "tcp",
			"containerPort": {{CONTAINERPORT}}
		}],
		"cpu": 512,
    "memory": 512,
		"environment": [],
		"mountPoints": [],
		"volumesFrom": [],
		"image": "{{IMAGE}}",
		"essential": true,
		"name": "{{TASK}}"
	}],
	"family": "{{TASKGROUP}}",
	"networkMode": "awsvpc",
	"volumes": [],
	"taskRoleArn": "{{AWS_ROLE}}"
}
