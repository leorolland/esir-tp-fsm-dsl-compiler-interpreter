package org.xtext.example.mydsl.compiler.java

import fr.leorolland.fsm.model.fsm.FSM
import fr.leorolland.fsm.model.fsm.State
import fr.leorolland.fsm.model.fsm.Transition

class Visitor {
	
	def String visitFSM(FSM f) {
		// Compile the FSM instanciation
		val compiledFSM = '''
		FSM myfsm = new FSM("«f.name»");
		'''
		// Visit all children
		val compiledInitialState = f.initialState.accept(this);
		val compiledFinalStates = f.finalStates.map[accept(this)].join()
		val compiledNormalStates = f.states.map[accept(this)].join()
		val compiledTransitions = f.transitions.map[accept(this)].join()
		// Compile the FSM
		return StaticAppTemplate.generate(
			compiledFSM,
			compiledInitialState,
			compiledFinalStates,
			compiledNormalStates,
			compiledTransitions
		)
	}
	
	def String visitTransition(Transition t) {
		// Compile the transition
		return '''
		Transition transition_« t.name » = new Transition("« t.name »", state_«t.from.name», state_«t.to.name», "« t.event »");
		myfsm.addTransition(transition_« t.name »);
		'''
	}
	
	def String visitState(State s) {
		// Compile the state
		return '''
		Etat state_« s.name » = new Etat("« s.name »", "« s.entry »");
		myfsm.addEtat(state_« s.name »);
		tmpList.add(state_« s.name »);
		'''
	}
		
		
	def String accept(State s, Visitor v) {
		return v.visitState(s);
	}
	
	
	def String accept(Transition s, Visitor v) {
		return v.visitTransition(s);
	}
	
}