import { SerialPort } from 'serialport'

const baudRate = 9600
const comPath = process.env.COM_PATH

const serialPort = new SerialPort({
  path: comPath,
  baudRate: baudRate,
})

serialPort.addListener('data', (chunk: Buffer) => {
  const now = new Date()

  console.info(now.toISOString())
  console.log(chunk.toString('utf-8'))
})

console.log(`listening on ${comPath} @${baudRate}`)
