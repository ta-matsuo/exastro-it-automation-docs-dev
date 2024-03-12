====================
Exastro Platform API
====================

.. raw:: html

   <div id="swagger-ui"></div>

   <script>
   $(function(){

     $('h1').remove();
     $('#article').attr('id', 'swaggerBody');

     $api_urls = [
       {url: "https://raw.githubusercontent.com/exastro-suite/exastro-platform/1.6/docs/openapi/build/openapi.yaml", name: "v1.6"}
     ];

     // Begin Swagger UI call region
     const ui = SwaggerUIBundle({
       urls: $api_urls,
       dom_id: '#swagger-ui',
       deepLinking: true,
       presets: [
         SwaggerUIBundle.presets.apis,
         SwaggerUIStandalonePreset
       ],
       plugins: [
         SwaggerUIBundle.plugins.DownloadUrl
       ],
       layout: "StandaloneLayout",
     });
     // End Swagger UI call region

     window.ui = ui;
   });
   </script>