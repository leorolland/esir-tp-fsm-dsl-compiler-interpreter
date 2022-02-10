package org.xtext.example.mydsl.interpreter.java

import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import java.util.Scanner
import java.util.LinkedList

class JavaInterpreter extends AbstractGenerator {
	
	override doGenerate(Resource input, IFileSystemAccess2 fsa, IGeneratorContext context) {
        var myScanner = new Scanner(System.in);
        var myfsm = new FSMInstance("door") //TOCHANGE
        System.out.print("Demarrage du fsm...");
        
        /**** BEGIN DYNAMIC PART ****/
        
		// ETAT INITIAL
		var tmpList = new LinkedList<Etat>();
        var state_closed = new Etat("closed", "close door"); //TOCHANGE
        myfsm.addEtat(state_closed); //TOCHANGE
        tmpList.add(state_closed);
		myfsm.addEtatInital(tmpList.get(0));
        
        // ETAT Finaux
		tmpList = new LinkedList<Etat>();
        var state_fin = new Etat("fin", "fin"); //TOCHANGE
        myfsm.addEtat(state_fin); //TOCHANGE
        tmpList.add(state_fin);
		myfsm.addEtatFinaux(tmpList);
        
        // COMPILATION DES STATES
		tmpList = new LinkedList<Etat>();
        var state_opened = new Etat("opened", "open door"); //TOCHANGE
        myfsm.addEtat(state_opened); //TOCHANGE
        tmpList.add(state_opened);
        
        var state_broken = new Etat("broken", "broken door"); //TOCHANGE
        myfsm.addEtat(state_broken); //TOCHANGE
        tmpList.add(state_broken);

        // COMPILATION DES TRANSITIONS
        var transition_open = new Transition("open", state_closed, state_opened, "on"); //TOCHANGE
        myfsm.addTransition(transition_open); //TOCHANGE
        
        var transition_close = new Transition("close", state_opened, state_closed, "off"); //TOCHANGE
        myfsm.addTransition(transition_close); //TOCHANGE
        
        var transition_b3 = new Transition("b3", state_closed, state_fin, "fin"); //TOCHANGE
        myfsm.addTransition(transition_b3); //TOCHANGE
        
        var transition_b1 = new Transition("b1", state_opened, state_broken, "warning"); //TOCHANGE
        myfsm.addTransition(transition_b1); //TOCHANGE
        
        var transition_b2 = new Transition("b2", state_closed, state_broken, "warning"); //TOCHANGE
        myfsm.addTransition(transition_b2); //TOCHANGE
        
        /**** END DYNAMIC PART ****/
        
        System.out.println("Noeud de depart : " + myfsm.getCurrentState().name);
        while(true) {
            System.out.print("Quelle action souhaites-tu faire : ");
            var choice = myScanner.next();
            myfsm.moveToNewState(choice);
            
            if(myfsm.AreWeOnFinalState()) {
                System.out.print("Etat de fin detecte, voulez-vous vous arreter [Y/n] ? ");
                var choice2 = myScanner.next();
                if(choice2.equals("Y")) {
                    System.out.println("Arret du FSM...");
                    return;
                }
            }
        }
    }
}