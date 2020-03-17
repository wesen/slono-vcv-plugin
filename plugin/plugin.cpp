#include "plugin.hpp"
#include "MyModule.h"


Plugin* pluginInstance;


void init(Plugin* p) {
	pluginInstance = p;

	// Add modules here
    Model *const model = createModel<MyModule, MyModuleWidget>("MyModule");
    p->addModel(model);

	// Any other plugin initialization may go here.
	// As an alternative, consider lazy-loading assets and lookup tables when your module is created to reduce startup times of Rack.
}
