package org.xtext.example.mydsl.compiler.java

import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import fr.leorolland.fsm.model.fsm.FSM
import fr.leorolland.fsm.model.fsm.State
import fr.leorolland.fsm.model.fsm.Transition

class JavaCompiler extends AbstractGenerator {
	
	override doGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
		var visitor = new Visitor()
		
		// Compile all FSM
     	for(e : input.allContents.toIterable.filter(typeof(FSM))){
            fsa.generateFile('FsmCompiled.java',e.accept(visitor))
        }
	}
	
	def CharSequence accept(FSM fsm, Visitor v) {
		// Visite de l'état initial
		var initialStateCompiled = v.visit(fsm.initialState);
		// Visite des états finaux
		var finalStatesCompiled = fsm.finalStates.filter(typeof(State)).filter(s | s != fsm.initialState).map[accept(v)].join('\n')
		// Visite des autres états
		var statesCompiled = fsm.eAllContents.toIterable.filter(typeof(State)).filter(s | s != fsm.initialState && !fsm.finalStates.contains(s)).map[accept(v)].join('\n')
		// Visite des transitions
		var transitionsCompiled = fsm.eAllContents.toIterable.filter(typeof(Transition)).filter(s | s != fsm.initialState && !fsm.finalStates.contains(s)).map[accept(v)].join('\n')
		// Compilation fsm
		var fsmCompiled = v.visit(fsm)
		return StaticAppTemplate.generate(fsmCompiled, initialStateCompiled, finalStatesCompiled, statesCompiled, transitionsCompiled) 
	}
	
	def CharSequence accept(State s, Visitor v) {
		return v.visit(s);
	}
	
	def CharSequence accept(Transition s, Visitor v) {
		return v.visit(s);
	}
	
    
}