package org.xtext.example.mydsl.interpreter.java

import fr.leorolland.fsm.model.fsm.State
import fr.leorolland.fsm.model.fsm.FSM
import org.eclipse.emf.common.util.EList
import fr.leorolland.fsm.model.fsm.Transition
import java.util.Scanner

class VisitorInterpretor {

	val scanner = new Scanner(System.in);	
	var EList<Transition> transitions;
	
	
	def visitFSM(FSM f) {
		println("exécution du FSM")
		this.transitions = f.transitions
		f.initialState.accept(this)
	}
		
	def visitState(State o){
		println("Vous êtes dans l'état " + o.name)
		var nextTransitions = this.transitions.filter[t | t.from.name.equals(o.name)]
		var Transition chosenTransition = null;
		do {
			println("Choisissez une transition :")
			nextTransitions.forEach[t | println(" > " + t.event)]
			val input = scanner.next()
			chosenTransition = nextTransitions.findFirst[t | t.event.equals(input)]
		} while (chosenTransition == null)
		chosenTransition.accept(this)
	}
	
	def accept(Transition t, VisitorInterpretor v) {
		println("Vous avez lancé la transition " + t.name)
		v.visitState(t.to)
	}
	
	def accept(State s, VisitorInterpretor v) {
		v.visitState(s);
	}
	
}