import { EventService } from './services/event-service'
import { SerialPort } from 'serialport'

const baudRate = 9600
const comPath = process.env.COM_PATH

const eventService = new EventService()

const serialPort = new SerialPort({
  path: comPath,
  baudRate: baudRate,
})

serialPort.addListener('data', async (chunk: Buffer) => {
  try {
    const now = new Date()

    const message = chunk.toString('utf-8')

    console.info(now.toISOString())
    console.log(message)

    if (message === 'detected') {
      await eventService.detection()
    }
  } catch (error) {
    console.info('error')
    console.error(error)
  }
})

console.log(`listening on ${comPath} @${baudRate}`)
