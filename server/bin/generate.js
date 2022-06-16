const { ModelRoleGenerate, ModelStatusGenerate, ModelTypeGenerate } = require("./model_generate");

const ModelGetnerate = async () => {
    ModelRoleGenerate();
    ModelStatusGenerate();
    ModelTypeGenerate();
}

module.exports = { ModelGetnerate };