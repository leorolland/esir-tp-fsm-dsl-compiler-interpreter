package org.xtext.example.mydsl.generator.java

class StaticAppTemplate {
    def static generate(String fsm, String initialState, String states, String transitions) {
        return '''
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;

public class FsmCompiled {

    public static void main(String[] args) {
        @SuppressWarnings("resource")
        Scanner myScanner = new Scanner(System.in);
        List<Etat> endstates = new LinkedList<Etat>();
        «fsm»
        System.out.println("Demarrage du fsm...");
        
        /**** BEGIN DYNAMIC PART ****/
        // ETAT INITIAL
        «initialState»
        
        // COMPILATION DES STATES
        «states»

        // COMPILATION DES TRANSITIONS
        «transitions»
        
        /**** END DYNAMIC PART ****/
        
        System.out.println("Noeud de depart : " + myfsm.getCurrentState().name);
        while(true) {
            System.out.print("Quelle action souhaites-tu faire : ");
            String choice = myScanner.next();
            myfsm.moveToNewState(choice);
            
            boolean endpossible = myfsm.AreWeOnFinalState();
            if(endpossible) {
                System.out.print("Etat de fin detecte, voulez-vous vous arreter [Y/n] ? ");
                String choice2 = myScanner.next();
                if(choice2.equals("Y")) {
                    System.out.println("Arret du FSM...");
                    return;
                }
            }
        }
    }
}

class FSM {
    private String name;
    private Etat initState;
    private List<Etat> finalStates;
    private Etat currentState;
    private List<Etat> states;
    private List<Transition> transitions;


    public FSM(String name,List<Etat> finalStates) {
        this.name = name;
        this.finalStates = finalStates;
        this.states = new LinkedList<Etat>();
        this.transitions = new LinkedList<Transition>();
        
        this.states.add(initState);
        for(Etat e : finalStates) {
            this.states.add(e);
        }
        this.currentState = this.initState;
    }

    public boolean moveToNewState(String action) {
        List<Transition> transitions = this.findTransitionsCurrentState();
        for( Transition t : transitions) {
            if (t.action.equals(action)) {
                this.currentState = t.endEtat;
                System.out.println("# Deplacement vers l'etat |" + this.currentState.name + "| via la transition (" + t.name + ")");
                return true;
            }
        }
        System.out.println("# Impossible de se deplacer via l'action \"" + action + "\" depuis l'etat "+ this.currentState.name + ".");
        return false;
    }

    private List<Transition> findTransitionsCurrentState() {
        List<Transition> result = new LinkedList<Transition>();
        for( Transition t  : this.transitions) {
            if(t.startEtat == this.currentState)
                result.add(t);
        }
        return result;
    }
    
    public Etat getCurrentState() {
        return this.currentState;
    }
    
    public boolean AreWeOnFinalState() {
        for(Etat e : this.finalStates) {
            if (this.currentState == e)
                return true;
        }
        return false;
    }

    public List<Etat> addEtat(Etat state) {
        if(this.initState == null) {
            this.initState = state;
            this.currentState = this.initState;
        }

        this.states.add(state);
        return this.states;
    }

    public List<Transition> addTransition(Transition t) {
        this.transitions.add(t);
        return this.transitions;
    }
}

class Etat implements Comparable<Etat> {
    public String name;
    public String content;

    public Etat(String nom, String c) {
        this.name = nom;
        this.content = c;
    }

    @Override
    public int compareTo(Etat state) {
        return (state.name.compareTo(this.name) + state.content.compareTo(this.content)) / 2;
    }
}

class Transition {
    public String name;
    public String action;
    public Etat startEtat;
    public Etat endEtat;

    public Transition(String nom, Etat start, Etat end, String c) {
        this.name = nom;
        this.action = c;
        this.startEtat = start;
        this.endEtat = end;
    }
}
        '''
    }
}