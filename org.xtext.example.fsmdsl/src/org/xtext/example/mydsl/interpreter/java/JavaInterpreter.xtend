package org.xtext.example.mydsl.interpreter.java

import fr.leorolland.fsm.model.fsm.FSM
import org.eclipse.emf.ecore.resource.Resource

class JavaInterpreter {
	
	def execute(Resource input) {
		val visitor = new VisitorInterpretor()
		
		// Visit the FSM
		val fsm = input.allContents.toIterable.findFirst(e | e.eClass.name == "FSM") as FSM
		fsm.accept(visitor)
        
	}
	
	def void accept(FSM fsm, VisitorInterpretor interpretor) {
		interpretor.visitFSM(fsm)
	}
	
}