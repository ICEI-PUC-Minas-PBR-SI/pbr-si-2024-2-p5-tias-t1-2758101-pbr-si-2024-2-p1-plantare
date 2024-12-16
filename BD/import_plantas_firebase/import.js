const admin = require('firebase-admin');
const serviceAccount = require("C:\\Users\\camila.silva\\Downloads\\Plantare\\pbr-si-2024-2-p5-tias-t1-2758101-pbr-si-2024-2-p1-plantare\\BD\\import_plantas_firebase\\plantare-app-firebase-adminsdk-jkq64-e71a248fd1.json");  // Ajuste o caminho conforme necessário
const verdurasData = require("C:/Users/camila.silva/Downloads/Plantare/pbr-si-2024-2-p5-tias-t1-2758101-pbr-si-2024-2-p1-plantare/BD/import_plantas_firebase/verduras.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: 'https://verduras.firebaseio.com'
});

const db = admin.firestore();

async function importData() {
  const verdurasCollection = db.collection('verduras');
  
  if (Array.isArray(verdurasData.verduras)) {
    for (let i = 0; i < verdurasData.verduras.length; i++) {
      const verduras = verdurasData.verduras[i];
      if (typeof verduras === 'object' && !Array.isArray(verduras)) {
        await verdurasCollection.doc(verduras.nome).set(verduras);
        console.log(`verduras ${verduras.nome} importada com sucesso.`);
      } else {
        console.log(`O item no índice ${i} não é um objeto válido e foi ignorado.`);
      }
    }
  } else {
    console.log("O arquivo JSON não contém um array chamado 'verduras'.");
  }

  console.log('Importação concluída!');
}

importData().catch(console.error);
