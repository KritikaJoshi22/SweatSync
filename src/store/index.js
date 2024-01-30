import {createGlobalState} from 'react-hooks-global-state'

const { setGlobalState, useGlobalState, getGlobalState } = createGlobalState({
    modal: 'scale-0',
    updateModal:'scale-0',
    courseModal: 'scale-0',
    nftModal: 'scale-0',
    alert: { show: false, msg: '', color: '' },
    loading: { show: false, msg: '' },
    connectedAccount: '',
    nft: null,
    nfts: [],
    contract: null,
  })


  export {
    useGlobalState,
    setGlobalState,
    getGlobalState,
  }