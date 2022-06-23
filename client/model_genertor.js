
    function ModelGenerator(generate) {
        prompts({
                type: 'select',
                name: 'pilih',
                message: 'Pilih Menu',
                choices: [$ {
                    items
                }]

            }).then(({
                    pilih
                }) => {
                switch (pilih) {
                    
        case 'generate':
            item();
            break;
            
                    default:
                        break;
                })})
    }

    