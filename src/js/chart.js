﻿'use strict';
	var datascource;
	//alert( "aqui" );

		
(function ($) {

    $(function () {
		
		//alert( "Passando aqui" );

		jQuery.ajax({
            //url: "http://shrek.voxbras.com.br/vox2/t.php?callback=?",
			url: 'http://localhost:8082/datasnap/rest/TServerMethods/Search/iso',
            type: "GET",
            contentType: 'application/json; charset=utf-8',
            success: function(resultData) {
                //here is your json.
                  // process it
				datascource = resultData;
				console.log(datascource);				
            },
            error : function(jqXHR, textStatus, errorThrown) {
			 console.log(jqXHR);
			 console.log(textStatus);
			 console.log(errorThrown);
            },

            timeout: 120000,
        });
   
		console.log('Ajax ->');
		
		var datascource2 = {
            'id': '1',
            'name': 'Arlon',
            'title': 'Manager',
            'children': [{
                    'name': 'Software',
                    'title': 'Programas',
                    'children': [{
                            'name': 'Instalar',
                            'title': 'Instaladores'
                        }, {
                            'name': 'Standalone',
                            'title': 'Standalone',
                            'className': 'rd-dept',
                            'relationship': '110'
                        }, {
                            'id': '3',
                            'name': 'ISO',
                            'title': 'Imagem de midia',
                            'relationship': '111'
                        }
                    ]
                }, {
                    'name': 'Work',
                    'title': 'Coisas de trabalho',
                    'children': [{
                            'name': 'agcMiner',
                            'title': 'senior engineer',
                            'children': [{
                                    'name': 'Procurar',
                                    'title': '-'
                                }, {
                                    'name': 'Editar',
                                    'title': '-'
                                }, {
                                    'name': 'Visualizar',
                                    'title': '-'
                                }, {
                                    'name': 'Share',
                                    'title': '-',
                                    'children': [{
                                            'name': 'Get',
                                            'title': 'Download'
                                        }, {
                                            'name': 'Send',
                                            'title': 'Enviar'
                                        }
                                    ]
                                }
                            ]

                        }, {
                            'name': 'Arduino',
                            'title': 'Eletronica',
                            'className': 'middle-level'
                        }, {
                            'id': '1',
                            'name': 'Voxbras',
                            'title': 'Voxbras',
                            'className': 'frontend1'
                        },
                    ]
                }, {
                    'name': 'DIY',
                    'title': 'Faça você mesmo',
                    'className': 'pipeline1',
                    'children': [{
                            'name': 'Casinha',
                            'title': 'Casinha Sofia',
                            'className': 'product-dept',
                            'children': [{
                                    'name': 'principal',
                                    'title': 'principal.png'
                                }, {
                                    'name': 'casinha.jpg',
                                    'title': 'casinha5.jpg'
                                }
                            ]
                        }
                    ]
                }, {
                    'name': 'Hobby/Diversão',
                    'title': 'Hobby/Diversão'
                }, {
                    'name': 'Noticias',
                    'title': 'Canal de Noticias'
                }
            ]
        };

        $('#chart-container').orgchart({
            'pan': true,
            'zoom': true,
            //'verticalDepth': 4,
            //'depth': 3,
            'data': datascource, //  'http://localhost:779/datasnap/rest/TServerMethods1/Search/iso' 'http://shrek.voxbras.com.br/vox2/t.php'
            'nodeContent': 'title',
            'draggable': false,
            'dropCriteria': function ($draggedNode, $dragZone, $dropZone) {
                if ($draggedNode.find('.content').text().indexOf('manager') > -1 && $dropZone.find('.content').text().indexOf('engineer') > -1) {
                    return false;
                }
                return true;
            }
        })
        .children('.orgchart').on('nodedropped.orgchart', function (event) {
            console.log('draggedNode:' + event.draggedNode.children('.title').text()
                 + ', dragZone:' + event.dragZone.children('.title').text()
                 + ', dropZone:' + event.dropZone.children('.title').text());
        });

    });

})(jQuery);
