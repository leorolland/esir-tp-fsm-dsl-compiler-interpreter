/*
 * generated by Xtext 2.25.0
 */
package org.xtext.example.mydsl.ide;

import com.google.inject.Guice;
import com.google.inject.Injector;
import org.eclipse.xtext.util.Modules2;
import org.xtext.example.mydsl.FsmDslRuntimeModule;
import org.xtext.example.mydsl.FsmDslStandaloneSetup;

/**
 * Initialization support for running Xtext languages as language servers.
 */
public class FsmDslIdeSetup extends FsmDslStandaloneSetup {

	@Override
	public Injector createInjector() {
		return Guice.createInjector(Modules2.mixin(new FsmDslRuntimeModule(), new FsmDslIdeModule()));
	}
	
}
