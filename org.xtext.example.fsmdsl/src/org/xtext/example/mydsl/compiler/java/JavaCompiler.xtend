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
		val visitor = new Visitor()
		
		// Visit the FSM
		val fsm = input.allContents.toIterable.findFirst(e | e.eClass.name == "FSM") as FSM
		val compiledFsm = fsm.accept(visitor)
        
        // Write program to filesystem
        fsa.generateFile('FsmCompiled.java', compiledFsm)
	}

	def accept(FSM fsm, Visitor v) {
		v.visitFSM(fsm);
	}
	
}