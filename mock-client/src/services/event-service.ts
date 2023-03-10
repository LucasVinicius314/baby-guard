import axios from 'axios'

const apiProtocol = process.env.API_PROTOCOL
const apiAuthority = process.env.API_AUTHORITY

export class EventService {
  detection: () => Promise<void> = async () => {
    await axios({
      baseURL: `${apiProtocol}://${apiAuthority}/api/v1/`,
      url: 'event/detection',
      method: 'POST',
      data: {
        sensorId: 'test',
      },
    })
  }
}
