package org.xtext.example.mydsl.compiler.java

import org.eclipse.emf.ecore.EObject
import fr.leorolland.fsm.model.fsm.FSM
import fr.leorolland.fsm.model.fsm.State
import fr.leorolland.fsm.model.fsm.Transition

class Visitor {
		
	def visit(EObject o) {
		switch (o.eClass().name) {
			case "FSM": {
				val f = o as FSM
				return '''
					FSM myfsm = new FSM("«f.name»");
				'''
			}
			case "State": {
				val s = o as State
				return '''
				Etat state_« s.name » = new Etat("« s.name »", "« s.entry »");
				myfsm.addEtat(state_« s.name »);
				tmpList.add(state_« s.name »);
				'''
			}
			case "Transition": {
				val t = o as Transition
				return '''
				Transition transition_« t.name » = new Transition("« t.name »", state_«t.from.name», state_«t.to.name», "« t.event »");
				myfsm.addTransition(transition_« t.name »);
				'''				
			}
			default: {
				return "throw new Error('Compilation error')"
			}
		}
	}
	
}