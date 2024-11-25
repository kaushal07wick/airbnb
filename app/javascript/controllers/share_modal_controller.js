import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  copyLink() {
    navigator.clipboard.writeText(this.element.dataset.shareUrl).then(() => {
      alert("Copied to clipboard");
    });
  }

  // WhatsApp Share
  whatsappShare() {
    const shareText = encodeURIComponent(this.element.dataset.shareUrl);
    const whatsappUrl = `https://wa.me/?text=${shareText}`;
    window.open(whatsappUrl, '_blank');
  }

  // Twitter Share
  twitterShare() {
    const shareText = encodeURIComponent(this.element.dataset.shareUrl);
    const twitterUrl = `https://twitter.com/intent/tweet?url=${shareText}`;
    window.open(twitterUrl, '_blank');
  }

  // Facebook Share
  facebookShare() {
    const shareUrl = encodeURIComponent(this.element.dataset.shareUrl);
    const facebookUrl = `https://www.facebook.com/sharer/sharer.php?u=${shareUrl}`;
    window.open(facebookUrl, '_blank');
  }

  // Email Share
  emailShare() {
    const shareUrl = encodeURIComponent(this.element.dataset.shareUrl);
    const subject = encodeURIComponent('Check this out!');
    const body = encodeURIComponent(`I found this interesting: ${this.element.dataset.shareUrl}`);
    const emailUrl = `mailto:?subject=${subject}&body=${body}`;
    window.open(emailUrl, '_blank');
  }

  // Embed Link
  embedLink() {
    const embedCode = `<iframe src="${this.element.dataset.shareUrl}" width="600" height="400"></iframe>`;
    prompt('Copy the embed code:', embedCode);
  }

  // Messenger Share
  messengerShare() {
    const shareUrl = encodeURIComponent(this.element.dataset.shareUrl);
    const messengerUrl = `https://www.messenger.com/t/?link=${shareUrl}`;
    window.open(messengerUrl, '_blank');
  }

  // Messages Share (Apple iMessage)
  messagesShare() {
    const shareUrl = encodeURIComponent(this.element.dataset.shareUrl);
    const messagesUrl = `sms:?&body=${shareUrl}`;
    window.open(messagesUrl, '_blank');
  }
}
