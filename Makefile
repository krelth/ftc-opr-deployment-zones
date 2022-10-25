.PHONY = build clean rebuild publish
NAME = OPR\ Deployment\ Zones\ for\ FTC

SRC_DIR = src
BIN_DIR = dist
PUBLISH_DIR = $${HOME}/.local/share/Tabletop Simulator/Saves/Saved Objects/

#######################################################################

build:	\
	$(BIN_DIR)/$(NAME).json \
	$(BIN_DIR)/$(NAME).png

clean:
	rm -rf $(BIN_DIR)/*

rebuild:
	make clean build

publish: \
	$(BIN_DIR)/$(NAME).json \
	$(BIN_DIR)/$(NAME).png

	cp dist/* "$(PUBLISH_DIR)"

#######################################################################

node_modules:
	npm install

$(BIN_DIR)/$(NAME).json: \
	$(SRC_DIR)/object.json \
	$(SRC_DIR)/script.lua \
	$(SRC_DIR)/deploymentZones/ambush.lua \
	$(SRC_DIR)/deploymentZones/cornered.lua \
	$(SRC_DIR)/deploymentZones/flankAssault.lua \
	$(SRC_DIR)/deploymentZones/flankAssaultGff.lua \
	$(SRC_DIR)/deploymentZones/frontLine.lua \
	$(SRC_DIR)/deploymentZones/kitchenFlankAssault.lua \
	$(SRC_DIR)/deploymentZones/kitchenFrontline.lua \
	$(SRC_DIR)/deploymentZones/kitchenSideBattle.lua \
	$(SRC_DIR)/deploymentZones/longHaul.lua \
	$(SRC_DIR)/deploymentZones/sideBattle.lua \
	$(SRC_DIR)/deploymentZones/spearhead.lua \
	$(SRC_DIR)/deploymentZones/spearheadGff.lua \
	$(SRC_DIR)/ui.xml \
	| $(BIN_DIR) \
	node_modules

	npx hbs-cli \
		--helper ./$(SRC_DIR)/helpers.js \
		--partial $(SRC_DIR)/script.lua \
		--partial $(SRC_DIR)/ui.xml \
		--partial '$(SRC_DIR)/deploymentZones/*' \
		--output $(BIN_DIR) \
		--extension json \
		$(SRC_DIR)/object.json && \
	mv $(BIN_DIR)/object.json "$@"

$(BIN_DIR)/$(NAME).png:	$(SRC_DIR)/thumb.png
	cp $< "$@"

$(BIN_DIR):
	mkdir $(BIN_DIR)
